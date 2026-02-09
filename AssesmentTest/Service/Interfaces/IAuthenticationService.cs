using Repository.Data;

namespace Service.Interfaces;

public interface IAuthenticationService
{
    public Task<User?> VerifyUser(string email, string password);
}
