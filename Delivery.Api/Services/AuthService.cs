
using Delivery.Api.CU;
using Delivery.Api.CU.Enums;
using Delivery.Api.Dtos.AuthDtos;
using Delivery.Api.Models.Context;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Mail;
using System.Security.Claims;
using System.Text;



namespace Delivery.Api.Services
{
    public class AuthService
    {
        private readonly UserManager<IdentityUser> _userManager;
        private readonly SignInManager<IdentityUser> _signInManager;
        private readonly RestaurantDeliveryDbContext _dbContext;
        private readonly JWT _jwt;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly ILogger<AuthService> _logger;


        public AuthService(
            UserManager<IdentityUser> userManager,
            SignInManager<IdentityUser> signInManager,
            IOptions<JWT> jwt,
            RestaurantDeliveryDbContext dbContext,
            ILogger<AuthService> logger,
            RoleManager<IdentityRole> roleManager
            )
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _roleManager = roleManager;
            _jwt = jwt.Value;
            _logger = logger;
            _roleManager = roleManager;
            _dbContext = dbContext;


        }



        #region public methods
        public async Task<RegistrationResult> Register(RegisterDto model)
        {
            var email = model.Email;
            var password = model.Password;
            var username = model.Username;


            var existingUser = await _userManager.FindByEmailAsync(email);
            if (existingUser != null)
            {
                return new RegistrationResult { Status = RegistrationStatus.UserAlreadyExists, Message = "User already exists." };
            }


            var newUser = new IdentityUser
            {
                Email = email,
                UserName = email
            };

            try
            {

                var result = await _userManager.CreateAsync(newUser, password);
                if (!result.Succeeded)
                {
                    _logger.LogWarning("Failed to create role.");

                    // Rollback transaction and return false
                    return new RegistrationResult { Status = RegistrationStatus.OtherError, Message = "Failed to create user." };
                }

                var roleExists = await _roleManager.RoleExistsAsync(Role.Client);
                if (!roleExists)
                {
                    // Role does not exist, create it
                    var roleResult = await _roleManager.CreateAsync(new IdentityRole(Role.Client));
                    if (!roleResult.Succeeded)
                    {
                        _logger.LogWarning("Failed to create role.");

                        return new RegistrationResult { Status = RegistrationStatus.OtherError, Message = "Failed to create client role." };
                    }
                }

                var addToRoleResult = await _userManager.AddToRoleAsync(newUser, Role.Client);
                if (!addToRoleResult.Succeeded)
                {
                    _logger.LogWarning("Failed to add user to role.");

                    return new RegistrationResult { Status = RegistrationStatus.OtherError, Message = "Failed to add user to client role." };
                }
                return new RegistrationResult { Status = RegistrationStatus.Success, Message = "User registered successfully." };
            }
            catch (Exception ex)
            {

                _logger.LogError(ex, "An error occurred during register.");
                return new RegistrationResult { Status = RegistrationStatus.OtherError, Message = "An error occurred during registration." };

            }

        }

        public async Task<string> Login(LoginDto model)
        {
            try
            {
                var user = await _userManager.FindByEmailAsync(model.Email);
                if (user == null || !await _userManager.CheckPasswordAsync(user, model.Password))
                {
                    _logger.LogWarning("Invalid login attempt: User not found or invalid password.");
                    return null;

                }


                var token = await GenerateJwtToken(user);
                return token;
            }
            catch (Exception ex)
            {
                // Log or handle the exception appropriately
                _logger.LogError(ex, "An error occurred during login.");
                return null;
            }
        }

        #endregion

        #region private methods

        private async Task<string> GenerateJwtToken(IdentityUser user)
        {


            var roles = await _userManager.GetRolesAsync(user);
            var roleClaims = new List<Claim>();


            foreach (var role in roles)
                roleClaims.Add(new Claim(ClaimTypes.Role, role));

            var claims = new List<Claim>
            {
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.NameIdentifier, user.Id),

            }
            .Union(roleClaims);

            var symmetricSecurityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwt.Key));
            var signingCredintials = new SigningCredentials(symmetricSecurityKey, SecurityAlgorithms.HmacSha256);

            var jwtToken = new JwtSecurityToken(
            issuer: _jwt.Issuer,
            audience: _jwt.Audience,
            claims: claims,
            notBefore: DateTime.UtcNow,
            expires: DateTime.UtcNow.AddDays(_jwt.DurationInDays),
                signingCredentials: signingCredintials
                );

            return new JwtSecurityTokenHandler().WriteToken(jwtToken);


        }

        #endregion
    }
}


