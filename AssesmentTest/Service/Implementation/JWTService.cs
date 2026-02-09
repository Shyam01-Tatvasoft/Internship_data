using System.IdentityModel.Tokens.Jwt;
using System.Runtime.Serialization.Json;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Repository.Data;
using Repository.Interfaces;
using Service.Interfaces;

namespace Service.Implementation;

public class JWTService : IJWTService
{
    private readonly IConfiguration _config;
    private readonly IUserRepository _userRepository;
    private readonly string _key;
    private readonly string _issuer;
    private readonly string _audience;

    public JWTService(IConfiguration config,IUserRepository userRepository)
    {
        _userRepository = userRepository;
        _config = config;
        _key = config["Jwt:Key"]!;
        _issuer = config["Jwt:Issuer"]!;
        _audience = config["Jwt:Audience"]!;
    }

    public async Task<string> GenerateToken(string email)
    {
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_key));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        User? user = await _userRepository.GetUserByEmail(email);
        var authClaims = new List<Claim>{
            new Claim(ClaimTypes.Email, email),
            new Claim(ClaimTypes.Role, user.Role),
            new Claim(ClaimTypes.NameIdentifier,user.Id.ToString())
         };

        var token = new JwtSecurityToken(
            issuer: _issuer,
            audience: _audience,
            claims: authClaims,
            expires: DateTime.UtcNow.AddHours(3),
            signingCredentials: credentials
        );
        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    public (string?, string?, string?) ValidateToken(string token)
    {
        var tokenHandler = new JwtSecurityTokenHandler();
        var key = Encoding.UTF8.GetBytes(_key);

        try
        {
            var validationParameters = new TokenValidationParameters
            {
                ValidateIssuer = true,
                ValidateAudience = true,
                ValidateLifetime = true,
                ValidateIssuerSigningKey = true,
                ValidIssuer = _issuer,
                ValidAudience = _audience,
                IssuerSigningKey = new SymmetricSecurityKey(key)
            };

            var principal = tokenHandler.ValidateToken(token, validationParameters, out SecurityToken validatedToken);
            var email = principal.FindFirst(ClaimTypes.Email)?.Value.Trim();
            var role = principal.FindFirst(ClaimTypes.Role)?.Value.Trim();
            var userId = principal.FindFirst(ClaimTypes.NameIdentifier)?.Value.Trim().ToString();
            return (email, role, userId);
        }
        catch (Exception ex)
        {
            return (null, null, null);
        }
    }
}
