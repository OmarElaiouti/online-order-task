using Delivery.Api.Models.Context;
using Delivery.Api.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Delivery.Api.Dtos;
using AutoMapper;
using Newtonsoft.Json;
using Microsoft.EntityFrameworkCore;
using Delivery.Api.Services;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

namespace Delivery.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly RestaurantDeliveryDbContext _context;
        private readonly IMapper _mapper;
        private readonly ILogger<OrderController> _logger;
        private readonly EmailService _emailService;
        public OrderController(RestaurantDeliveryDbContext context, IMapper mapper, ILogger<OrderController> logger, EmailService emailService)
        {
            _context = context;
            _mapper = mapper;
            _logger = logger;
            _emailService = emailService;
        }

        [HttpPost]
        //[Authorize]
        [Route("confirm")]
        public async Task<IActionResult> CreateOrder([FromBody] OrderDto orderDto)
        {
            
            if (orderDto == null)
            {
                return BadRequest("Invalid order data.");
            }

            try
            {
                string? customerId = User.FindFirst(ClaimTypes.NameIdentifier)?
                    .Value;

                var newOrder = _mapper.Map<Order>(orderDto);

                _context.Orders.Add(newOrder);
                await _context.SaveChangesAsync();

                var orderItems = await _context.OrderItems
                            .Include(oi => oi.MenuItem)
                            .ThenInclude(mi => mi.Restaurant)
                            .Where(o=>o.OrderId== newOrder.OrderId)
                            .ToListAsync();

            

                var detailedOrderResponse = new OrdarDetailsDto
                {
                    OrderId = newOrder.OrderId,
                    CustomerName = newOrder.CustomerName,
                    TotalAmount = orderItems.Sum(oi => oi.TotalPrice),
                    OrderItems = orderItems.Select(oi => new OrdarItemDetailsDto
                    {
                        OrderItemId = oi.OrderItemId,
                        Quantity = oi.Quantity,
                        TotalPrice = oi.TotalPrice,
                        MenuItemName = oi.MenuItem.Name,
                        MenuItemPrice = oi.MenuItem.Price,
                        RestaurantName = oi.MenuItem.Restaurant.Name
                    }).ToList()
                };

                var emailBody = $@"
<!DOCTYPE html>
<html>
<head>
    <style>
        .receipt-items {{ font-family: Arial, sans-serif; }}
        table {{ width: 100%; border-collapse: collapse; }}
        th, td {{ padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }}
    </style>
</head>
<body>
    <div class='text-left'>
        <div><strong>Customer:</strong> {newOrder.CustomerName}</div>
        <div><strong>Order Code:</strong> {newOrder.OrderId}</div>
        <div><strong>Time:</strong> {DateTime.Now.ToString("F")}</div>
        <hr />
        <div class='receipt-items'>
            <table class='table table-borderless'>
                <thead>
                    <tr><th>Item</th><th>Price</th><th>Quantity</th><th>Total</th><th>Restaurant</th></tr>
                </thead>
                <tbody>
                    {string.Join("", orderItems.Select(oi => $@"
                        <tr>
                            <td>{oi.MenuItem.Name}</td>
                            <td>${oi.MenuItem.Price}</td>
                            <td>{oi.Quantity}</td>
                            <td>${oi.TotalPrice}</td>
                            <td>{oi.MenuItem.Restaurant.Name}</td>
                        </tr>"))}
                </tbody>
            </table>
            <hr />
            <p><strong>Total Amount: ${detailedOrderResponse.TotalAmount}</strong></p>
            <p>Your order will arrive as soon as possible.</p>
            <p>Thank you for ordering with us!</p>
        </div>
    </div>
</body>
</html>";
                await _emailService.SendEmailAsync(
                    newOrder.CustomerEmail, 
                    "Order Confirmation",
                    emailBody);

                return Ok(detailedOrderResponse);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while processing the order.");

                return StatusCode(500, "Internal server error occurred while processing the order.");
            }
        }

    }
}
