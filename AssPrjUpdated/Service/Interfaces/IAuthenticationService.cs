using Repository.Data;
using Repository.ViewModels;

namespace Service.Interfaces;

public interface IAuthenticationService
{
    public Task<User?> VerifyUser(string email, string password);
    public Task AddUser(RegisterViewModel model);
    public Task<User?> GetUserByEmail(string email);
}
