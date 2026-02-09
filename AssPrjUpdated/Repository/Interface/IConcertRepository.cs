using Repository.Data;
using Repository.ViewModels;

namespace Repository.Interface;

public interface IConcertRepository
{
    public Task<List<Concerts>> GetConcerts(string? searchString, string? artistName, DateTime? startDate, DateTime? endDate, string? venueType, string? venueBy);
    public Task<bool> AddConcert(AddEditConcertViewModel model);
    public Task<bool> EditConcert(AddEditConcertViewModel model);
    public Task DeleteConcert(int id);
    public Task<AddEditConcertViewModel> GetConcertById(int id);
}
