int mapYear(String year) {
  switch (year) {
    case '1st year': return 1;
    case '2nd year': return 2;
    case '3rd year': return 3;
    case '4th year': return 4;
    case '5th year': return 5;
    default: return 1;
  }
}

String mapHostel(String hostel) {
  switch (hostel) {
    case 'Ambika Girls Hostel': return 'AGH';
    case 'Parvati Girls Hostel': return 'PGH';
    case 'Manimahesh Girls Hostel': return 'MMH';
  }
  return '';
}