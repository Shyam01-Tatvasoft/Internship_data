using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Repository.Data;

public class Booking
{
    public int Id { get; set; }

    public int UserId { get; set; }
    public int ConcertId { get; set; }

    [Required]
    public int NoOfSeats { get; set; }

    [Required]
    [Column(TypeName = "decimal(10,2)")]
    public decimal Amount { get; set; }

    [Required]
    [Column(TypeName = "decimal(10,2)")]
    public decimal TotalAmount { get; set; }

    [Required]
    [Column(TypeName = "decimal(10,2)")]
    public decimal Discount { get; set; }

    [Column(TypeName = "timestamp without time zone")]
    public DateTime CreatedDate { get; set; }

    [ForeignKey("ConcertId")]
    public virtual Concerts Concerts { get; set; }

    [ForeignKey("UserId")]
    public virtual User User { get; set; }
}
