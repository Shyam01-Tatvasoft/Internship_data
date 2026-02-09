using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Repository.Data;
using Repository.Interface;
using Repository.ViewModels;

namespace Repository.Implementation;

public class ConcertRepository : IConcertRepository
{
    private readonly DatabaseContext _context;
    public ConcertRepository(DatabaseContext context)
    {
        _context = context;
    }

    public async Task<List<Concerts>> GetConcerts(string? searchString, string? artistName, DateTime? startDate, DateTime? endDate, string? venueType, string? venueBy)
    {
        return await _context.Concerts.Where(c => c.IsDeleted == false && c.CreatedDate < DateTime.Now && 
        (string.IsNullOrEmpty(searchString) || c.Title.ToLower().Contains(searchString.ToLower())) &&
        (string.IsNullOrEmpty(artistName) || c.ArtistName.ToLower().Contains(artistName.ToLower()))
        ).OrderBy(c => c.Id)
        .ToListAsync();
    }

    public async Task<bool> AddConcert(AddEditConcertViewModel model)
    {
        Concerts concert = new Concerts
        {
            Title = model.Title,
            ArtistName = model.ArtistName,
            TicketPrice = model.TicketPrice,
            Date = model.Date,
            Time = model.Time,
            DiscountPercentage = model.DiscountPercentage,
            DiscountSeats = (int)model.DiscountSeats,
            TotalSeats = model.TotalSeats,
            State = model.State,
            City = model.City,
            Country = model.Country,
            CreatedDate = DateTime.Now,
            Address = model.Address,
            AvailableSeats = model.TotalSeats
        };

        await _context.AddAsync(concert);
        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> EditConcert(AddEditConcertViewModel model)
    {
        Concerts concert = await _context.Concerts.FirstOrDefaultAsync(c => c.Id == model.Id);
        if (concert == null)
        {
            return false;
        }
        concert.Title = model.Title;
        concert.AvailableSeats = model.TotalSeats - (concert.TotalSeats - concert.AvailableSeats);
        concert.ArtistName = model.ArtistName;
        concert.TicketPrice = model.TicketPrice;
        concert.Date = model.Date;
        concert.Time = model.Time;
        concert.DiscountPercentage = model.DiscountPercentage;
        concert.DiscountSeats = (int)model.DiscountSeats!;
        concert.TotalSeats = model.TotalSeats;
        concert.State = model.State;
        concert.City = model.City;
        concert.Country = model.Country;
        concert.CreatedDate = DateTime.Now;
        concert.Address = model.Address;

        await _context.SaveChangesAsync();
        return true;
    }

    public async Task DeleteConcert(int id)
    {
        Concerts? concert = await _context.Concerts.FirstOrDefaultAsync(c => c.Id == id);
        concert.IsDeleted = true;
        await _context.SaveChangesAsync();
    }

    public async Task<AddEditConcertViewModel> GetConcertById(int id)
    {
        Concerts concert = await _context.Concerts.FirstOrDefaultAsync(c => c.Id == id);
        AddEditConcertViewModel editConcert = new AddEditConcertViewModel
        {
            Id = concert.Id,
            Title = concert.Title,
            ArtistName = concert.ArtistName,
            TicketPrice = concert.TicketPrice,
            Date = concert.Date,
            Time = concert.Time,
            DiscountPercentage = concert.DiscountPercentage,
            DiscountSeats = (int)concert.DiscountSeats,
            TotalSeats = concert.TotalSeats,
            State = concert.State,
            City = concert.City,
            Country = concert.Country,
            Address = concert.Address
        };
        return editConcert;
        
    }
}
