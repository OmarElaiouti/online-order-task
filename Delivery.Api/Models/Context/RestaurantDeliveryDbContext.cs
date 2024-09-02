using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Delivery.Api.Models.Context
{
    public class RestaurantDeliveryDbContext : IdentityDbContext<IdentityUser>
    {

        public RestaurantDeliveryDbContext(DbContextOptions<RestaurantDeliveryDbContext> options)
            : base(options)
        {
        }

        public DbSet<Restaurant> Restaurants { get; set; }
        public DbSet<MenuItem> MenuItems { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderItem> OrderItems { get; set; }
        public DbSet<City> Cities { get; set; }

    }
}
