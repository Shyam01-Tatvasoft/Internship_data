using System.Threading.Tasks;
using Repository.Data;
using Repository.Interface;
using Repository.ViewModels;

namespace Repository.Implementation;

public class UserRepository : IUserRepository
{
    private readonly DatabaseContext _context;

    public UserRepository(DatabaseContext context)
    {
        _context = context;
    }

    public async Task<User> GetUserByEmail(string email)
    {
        User user = _context.Users.FirstOrDefault(u => u.Email == email);
        return user;
    }

    public async Task AddNewUser(RegisterViewModel model)
    {
        User user = new User
        {
            Name = model.Name,
            Email = model.Email.ToLower(),
            Password = model.Password,
            Role = "User",
            Phone = model.Phone!,
            CreatedDate = DateTime.Now
        };
        await _context.AddAsync(user);
        await _context.SaveChangesAsync();
    }
}
