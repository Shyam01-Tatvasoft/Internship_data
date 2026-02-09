using Repository.ViewModels;

namespace Service.Interfaces;

public interface IConcertService
{
    public Task<List<ConcertViewModel>> GetConcerts(string? searchString, string? artistName, DateTime? startDate, DateTime? endDate, string? venueType, string? venueBy);
    public Task<AddEditConcertViewModel> GetConcertbyId(int id);
    public Task AddConcert(AddEditConcertViewModel model);
    public Task EditConcert(AddEditConcertViewModel model);
    public Task DeleteConcert(int id);
    public Task AddBooking(BookConcertViewModel model);
    public Task<List<BookingViewModel>> GetBookings();
}
