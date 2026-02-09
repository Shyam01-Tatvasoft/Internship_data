using Microsoft.EntityFrameworkCore;
using Repository.Data;
using Repository.Interfaces;

namespace Repository.Implementation;

public class UserRepository:IUserRepository
{
    private readonly AssessmentContext _context;

    public UserRepository(AssessmentContext context)
    {
        _context = context;
    }

    public async Task<User> GetUserByEmail(string email)
    {
        User user = await _context.Users.FirstOrDefaultAsync(u => u.Email == email);
        return user;
    }
}
