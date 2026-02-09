using System.Threading.Tasks;
using Repository.Data;
using Repository.Interface;
using Repository.ViewModels;
using Service.Interfaces;

namespace Service.Implementarion;

public class AuthenticationService : IAuthenticationService
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

    public async Task<User?> GetUserByEmail(string email)
    {
        User? user = await _userRepository.GetUserByEmail(email);
        if (user == null)
            return null;
        else
            return user;
    }


    public async Task AddUser(RegisterViewModel model)
    {
        await _userRepository.AddNewUser(model);
    }
}
