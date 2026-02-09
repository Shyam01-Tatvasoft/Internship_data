using System.ComponentModel.DataAnnotations;

namespace Repository.ViewModels;

public class ConcertViewModel
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;
    public string ArtistName { get; set; } = null!;

    public decimal TicketPrice { get; set; }

    public DateTime? Date { get; set; }

    public DateTime? Time { get; set; }

    public string State { get; set; } = null!;

    public string City { get; set; } = null!;

    public string Country { get; set; } = null!;

    public string Address { get; set; } = null!;

    public int? DiscountSeats { get; set; }

    public decimal DiscountPercentage { get; set; }

    public int TotalSeats { get; set; }

    public int AvailableSeats { get; set; }
}
