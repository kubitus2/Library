using System;
using System.Collections.Generic;

namespace Library.Infrastructure;

public partial class AvailabilityStatus
{
    public int Id { get; set; }

    public string Type { get; set; } = null!;

    public virtual ICollection<BookCopy> BookCopies { get; set; } = new List<BookCopy>();
}
