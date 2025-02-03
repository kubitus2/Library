using System;
using System.Collections.Generic;

namespace Library.Models;

public partial class Book
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;

    public string? Isbn { get; set; }

    public decimal? Price { get; set; }

    public string? Genre { get; set; }

    public int PublishedYear { get; set; }

    public bool? IsAvailableForSale { get; set; }

    public virtual ICollection<BookCopy> BookCopies { get; set; } = new List<BookCopy>();

    public virtual ICollection<Author> Authors { get; set; } = new List<Author>();
}