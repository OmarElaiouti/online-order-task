
using Delivery.Api.CU;
using Delivery.Api.Models.Context;
using Delivery.Api.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Delivery.Api
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.Configure<SmtpSettings>(builder.Configuration.GetSection("SmtpSettings"));
            builder.Services.Configure<JWT>(builder.Configuration.GetSection("JWT"));

            builder.Services.AddIdentity<IdentityUser, IdentityRole>()
                .AddEntityFrameworkStores<RestaurantDeliveryDbContext>()
                .AddDefaultTokenProviders();

            builder.Services.Configure<IdentityOptions>(options =>
            {
                options.Password.RequireDigit = true;
                options.Password.RequireLowercase = true;
                options.Password.RequireUppercase = true;
                options.Password.RequireNonAlphanumeric = true;
                options.Password.RequiredLength = 5;
                options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(30);
                options.Lockout.MaxFailedAccessAttempts = 5;
            });


            builder.Services.AddScoped<EmailService>();
            builder.Services.AddScoped<AuthService>();

            builder.Services.AddControllers();

            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();
            builder.Services.AddCors(options =>
            {
                

                options.AddPolicy("AllowSpecificOrigin", policyBuilder =>
                {
                    var corsSettings = builder.Configuration.GetSection("CorsSettings").Get<CorsSettings>();
                    policyBuilder
                        .WithOrigins(corsSettings.AllowedOrigins)
                        .AllowAnyHeader()
                        .AllowAnyMethod();
                });
            });
            builder.Services.AddDbContext<RestaurantDeliveryDbContext>(options =>
                options.UseSqlServer(builder.Configuration.GetConnectionString("localConn"))
                
                );

            builder.Services.AddAutoMapper(typeof(Program));
            builder.Logging.AddConsole();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();
            app.UseCors("AllowSpecificOrigin");

            app.UseAuthentication();
            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
