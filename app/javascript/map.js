document.addEventListener("DOMContentLoaded", function() {
  var wellKnownText = "<@ticket.well_known_text>"; // Replace with the actual WellKnownText info

  if (wellKnownText) {
    var trimmedWellKnownText = wellKnownText.trim();
    var coordinatesMatch = trimmedWellKnownText.match(/POLYGON\((.*?)\)/);

    console.log("coordinatesMatch:", coordinatesMatch);

    if (coordinatesMatch) {
      var coordinates = coordinatesMatch[1].split(" ");
      var latitude = parseFloat(coordinates[1]);
      var longitude = parseFloat(coordinates[0]);

      var map = L.map('map').setView([latitude, longitude], 13);

      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
        maxZoom: 18,
      }).addTo(map);

      L.marker([latitude, longitude]).addTo(map);
    } else {
      console.error("Invalid format of wellKnownText");
    }
  } else {
    console.error("wellKnownText is null or undefined");
  }
});



  