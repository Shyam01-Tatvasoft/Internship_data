using System.ComponentModel.DataAnnotations;

namespace Repository.ViewModels;

public class BookConcertViewModel
{
    public int? Id { get; set; }

    public int UserId { get; set; }
    public int ConcertId { get; set; }

    [Required]
    public int NoOfSeats { get; set; }

    [Required]
    public decimal Amount { get; set; }

    [Required]
    public decimal TotalAmount { get; set; }

    [Required]
    public decimal Discount { get; set; }

    public DateTime CreatedDate { get; set; }
}
