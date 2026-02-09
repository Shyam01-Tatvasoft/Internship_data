using Repository.Data;

namespace Repository.Interfaces;

public interface IUserRepository
{
    public Task<User> GetUserByEmail(string email);
}
