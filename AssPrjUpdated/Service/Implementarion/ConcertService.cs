using System.Threading.Tasks;
using Repository.Data;
using Repository.Interface;
using Repository.ViewModels;
using Service.Interfaces;

namespace Service.Implementarion;

public class ConcertService : IConcertService
{
    private readonly IConcertRepository _concertRepository;
    private readonly IBookingRepository _bookingRepository;
    public ConcertService(IConcertRepository concertRepository, IBookingRepository bookingRepository)
    {
        _concertRepository = concertRepository;
        _bookingRepository = bookingRepository;
    }

    public async Task<List<ConcertViewModel>> GetConcerts(string? searchString, string? artistName, DateTime? startDate, DateTime? endDate, string? venueType, string? venueBy)
    {
        List<Concerts> concerts = await _concertRepository.GetConcerts(searchString, artistName, startDate, endDate, venueType, venueBy);
        List<ConcertViewModel> concertList = new List<ConcertViewModel>();

        foreach (var c in concerts)
        {
            concertList.Add(new ConcertViewModel
            {
                Id = c.Id,
                Title = c.Title,
                ArtistName = c.ArtistName,
                TicketPrice = c.TicketPrice,
                Date = c.Date,
                Time = c.Time,
                DiscountPercentage = c.DiscountPercentage,
                DiscountSeats = c.DiscountSeats,
                TotalSeats = c.TotalSeats,
                State = c.State,
                City = c.City,
                Country = c.Country,
                Address = c.Address,
                AvailableSeats = c.AvailableSeats

            });
        }
        return concertList;
    }

    public async Task<AddEditConcertViewModel> GetConcertbyId(int id)
    {
        return await _concertRepository.GetConcertById(id);
    }

    public async Task AddConcert(AddEditConcertViewModel model)
    {
        await _concertRepository.AddConcert(model);
    }

    public async Task EditConcert(AddEditConcertViewModel model)
    {
        bool response = await _concertRepository.EditConcert(model);
    }

    public async Task DeleteConcert(int id)
    {
        await _concertRepository.DeleteConcert(id);
    }

    public async Task AddBooking(BookConcertViewModel model)
    {
        await _bookingRepository.AddBooking(model);
    }

    public async Task<List<BookingViewModel>> GetBookings()
    {
        return await _bookingRepository.GetAllBookings();
    }
}
