using Microsoft.AspNetCore.Authentication;
using Repository.Data;
using Repository.Interfaces;

namespace Service.Implementation;

public class AuthenticationService: Service.Interfaces.IAuthenticationService
{
    private readonly IUserRepository _userRepository;

    public AuthenticationService(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task<User?> VerifyUser(string email, string password)
    {
        var user = await _userRepository.GetUserByEmail(email);
        if (user == null)
            return null;
        if (password == user.Password)
        {
            return user;
        }
        return null;
    }
}
