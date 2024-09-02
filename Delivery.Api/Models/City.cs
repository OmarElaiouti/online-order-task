namespace Delivery.Api.Models
{
    public class City
    {
        public int CityId { get; set; }
        public string CityName { get; set; }
        public ICollection<Restaurant> Restaurants { get; set; }
    }
}
