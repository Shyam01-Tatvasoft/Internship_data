using Repository.ViewModels;

namespace Repository.Interface;

public interface IBookingRepository
{
    public Task AddBooking(BookConcertViewModel model);
    public Task<List<BookingViewModel>> GetAllBookings();
}
