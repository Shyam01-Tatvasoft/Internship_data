using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Repository.Data;
using Repository.Interface;
using Repository.ViewModels;

namespace Repository.Implementation;

public class BookingRepository : IBookingRepository
{
    private readonly DatabaseContext _context;
    public BookingRepository(DatabaseContext context)
    {
        _context = context;
    }

    public async Task AddBooking(BookConcertViewModel model)
    {
        Booking book = new Booking
        {
            ConcertId = model.ConcertId,
            UserId = model.UserId,
            Amount = model.Amount,
            TotalAmount = model.TotalAmount,
            CreatedDate = DateTime.Now,
            Discount = model.Discount,
            NoOfSeats = model.NoOfSeats
        };
        await _context.Booking.AddAsync(book);

        Concerts c = await _context.Concerts.FirstOrDefaultAsync(c => c.Id == model.ConcertId);
        c.AvailableSeats = c.AvailableSeats - model.NoOfSeats;

        await _context.SaveChangesAsync();
    }

    public async Task<List<BookingViewModel>> GetAllBookings()
    {
        return await _context.Booking.Select(b => new BookingViewModel
        {
            Id = b.Id,
            Amount = b.Amount,
            ConcertId = b.ConcertId,
            ConcertTitle = b.Concerts.Title,
            Discount = b.Discount,
            NoOfSeats = b.NoOfSeats,
            TotalAmount = b.TotalAmount,
            UserId = b.UserId,
            UserName = b.User.Name
        }).ToListAsync();
    }
}
