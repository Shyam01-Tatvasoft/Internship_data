using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace app.Data;

public class RefreshToken
{
    [Key]
    public int Id { get; set; }

    public string Token { get; set; } = string.Empty;

    [Column(TypeName = "timestamp without time zone")]
    public DateTime Expires { get; set; }

    public bool IsExpired => DateTime.UtcNow >= Expires;

    [Column(TypeName = "timestamp without time zone")]
    public DateTime Created { get; set; }

    [Column(TypeName = "timestamp without time zone")]
    public DateTime? Revoked { get; set; }

    public bool IsRevoked => Revoked != null;

    public bool IsActive => !IsRevoked && !IsExpired;

    public int UserId { get; set; }

    [ForeignKey("UserId")]
    public User User { get; set; } = null!;
}
