using System;
using System.Collections.Generic;

namespace Library.Infrastructure;

public partial class Checkout
{
    public int Id { get; set; }

    public int BookCopyId { get; set; }

    public int UserId { get; set; }

    public DateOnly BorrowDate { get; set; }

    public DateOnly? ReturnedDate { get; set; }

    public decimal? OverdueFee { get; set; }

    public virtual BookCopy BookCopy { get; set; } = null!;

    public virtual ICollection<Fee> Fees { get; set; } = new List<Fee>();

    public virtual User User { get; set; } = null!;
}
