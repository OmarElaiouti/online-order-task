﻿namespace Delivery.Api.Dtos
{
    public class CityDto
    {
        public int CityId { get; set; }
        public string CityName { get; set; }

        public List<RestaurantDto> Restaurants { get; set; }
    }
}
