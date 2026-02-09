namespace Repository.ViewModels;

public class BookingViewModel
{

    public int Id { get; set; }

    public int UserId { get; set; }
    public int ConcertId { get; set; }

    public int NoOfSeats { get; set; }

    public decimal Amount { get; set; }

    public decimal TotalAmount { get; set; }

    public decimal Discount { get; set; }

    public DateTime CreatedDate { get; set; }
    
    public string? ConcertTitle { get; set; }
    public string UserName { get; set; }
}
