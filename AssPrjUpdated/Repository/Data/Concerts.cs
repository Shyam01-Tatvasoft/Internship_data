using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Repository.Data;

public class Concerts
{
    [Key]
    public int Id { get; set; }
    [Required]
    [MaxLength(100)]
    public string Title { get; set; } = null!;

    [Required]
    [MaxLength(100)]
    public string ArtistName { get; set; } = null!;

    [Required]
    [Column(TypeName = "decimal(10,2)")]
    public decimal TicketPrice { get; set; }

    [Column(TypeName = "timestamp without time zone")]
    public DateTime? Date { get; set; }

    [Column(TypeName = "timestamp without time zone")]
    public DateTime? Time { get; set; }

    public string State { get; set; } = null!;

    public string City { get; set; } = null!;

    public string Country { get; set; } = null!;

    [Required]
    public string Address { get; set; } = null!;

    [Required]
    public int DiscountSeats { get; set; }

    [Column(TypeName = "decimal(10,2)")]
    public decimal DiscountPercentage { get; set; }

    [Required]
    public int TotalSeats { get; set; }

    [Column(TypeName = "timestamp without time zone")]
    public DateTime CreatedDate { get; set; }

    [DefaultValue("false")]
    public bool IsDeleted { get; set; }

    public int AvailableSeats { get; set; }
    

}
