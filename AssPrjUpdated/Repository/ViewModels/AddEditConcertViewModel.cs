using System.ComponentModel.DataAnnotations;

namespace Repository.ViewModels;

public class AddEditConcertViewModel
{
   public int? Id { get; set; }

    [Required(ErrorMessage = "Name is required.")]
    [MaxLength(50, ErrorMessage = "Name should be less then 50 character")]
    [RegularExpression(@"^[A-Za-z0-9]+(?:\s[A-Za-z0-9]+)*$", ErrorMessage = "Invalid name.")]
    public string Title { get; set; } = null!;

    [Required(ErrorMessage = "Artist Name is required.")]
    [MaxLength(50, ErrorMessage = "Artist Name should be less then 50 character")]
    [RegularExpression(@"^[A-Za-z0-9]+(?:\s[A-Za-z0-9]+)*$", ErrorMessage = "Invalid name.")]
    public string ArtistName { get; set; } = null!;

    [Required(ErrorMessage = "TicketPrice is required")]
    [Range(1, 99999999.99, ErrorMessage = "TicketPrice should be between 1 - 99999999.99")]
    [RegularExpression(@"^\d+(\.\d{1,2})?$", ErrorMessage = "TicketPrice should be in 12.12 form")]
    public decimal TicketPrice { get; set; }

    [Required(ErrorMessage = "Date is required.")]
    public DateTime? Date { get; set; }

    [Required(ErrorMessage = "Time is required.")]
    public DateTime? Time { get; set; }

    [Required(ErrorMessage = "State is required.")]
    public string State { get; set; } = null!;

    [Required(ErrorMessage = "City is required.")]
    public string City { get; set; } = null!;

    [Required(ErrorMessage = "County is required.")]
    public string Country { get; set; } = null!;

    [Required(ErrorMessage = "Address is required.")]
    public string Address { get; set; } = null!;

    [Required]
    [RegularExpression("([0-9]+)", ErrorMessage = "Invalid DiscountSeats")] 
    [Range(0, int.MaxValue, ErrorMessage = "Invalid DiscountSeats")]
    public int? DiscountSeats { get; set; }

    [Required]
    [Range(0, 100.00, ErrorMessage = "DiscountPercentage should be between 1 - 100.00")]
    [RegularExpression(@"^\d+(\.\d{1,2})?$", ErrorMessage = "DiscountPercentage should be in 12.12 form")]
    public decimal DiscountPercentage { get; set; }

    [RegularExpression("([0-9]+)",ErrorMessage = "Invalid TotalSeats")] 
    [Range(0, int.MaxValue, ErrorMessage = "Invalid TotalSeats")]
    public int TotalSeats { get; set; }
}
