using Repository.Data;
using Repository.ViewModels;

namespace Repository.Interface;

public interface IUserRepository
{
     public Task<User> GetUserByEmail(string email);
     public Task AddNewUser(RegisterViewModel model);
}
