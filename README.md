# College Football Schedule Matrix 2025

A comprehensive web application for displaying college football schedules in an interactive matrix format. Features both FBS and FCS teams with real-time data from ESPN APIs.

## Features

### 🏈 Complete Team Coverage
- **FBS Teams**: 136 teams across 11 conferences
- **FCS Teams**: 147 teams across 14 conferences
- **Total**: 283+ Division I college football teams

### 📊 Interactive Matrix Display
- **Collapsible Divisions**: FBS and FCS sections with expand/collapse
- **Conference Grouping**: Teams organized by conference with individual headers
- **Week-by-Week View**: Complete season schedule with 15+ weeks
- **Team Headers**: Each conference includes "Teams" and "Week 1-15" headers

### 🎯 Game Information
- **Win/Loss Indicators**: Visual background colors for game outcomes
- **Scores**: Displayed with team logos and scores
- **Home/Away**: Clear indication of home and away teams
- **Team Logos**: High-quality logos from ESPN API with fallback text
- **BYE Weeks**: Clearly marked for teams without games

### 🎨 Modern UI/UX
- **Responsive Design**: Works on desktop and mobile devices
- **Clean Interface**: Professional styling with intuitive navigation
- **Color-Coded Results**: Green for wins, red for losses, gray for ties
- **Smooth Animations**: Hover effects and transitions

### 🔄 Real-Time Data
- **ESPN API Integration**: Live data from ESPN's college football APIs
- **2025 Season**: Current season data with up-to-date schedules
- **Automatic Updates**: Fresh data on each page load

## Technical Details

### Built With
- **HTML5**: Semantic markup and structure
- **CSS3**: Modern styling with Grid and Flexbox
- **Vanilla JavaScript**: ES6+ features and classes
- **ESPN APIs**: 
  - Scoreboard API for game data
  - Teams API for team information and logos

### Browser Support
- Chrome 60+
- Firefox 55+
- Safari 12+
- Edge 79+

## Usage

1. **Open the Application**: Simply open `cfb-schedule.html` in your web browser
2. **Navigate Divisions**: Click on FBS or FCS headers to expand/collapse
3. **Browse Conferences**: Click on conference names to show/hide teams
4. **View Games**: Each cell shows opponent, score, and outcome
5. **Mobile Friendly**: Responsive design works on all screen sizes

## File Structure

```
Dutch/
├── cfb-schedule.html    # Main application file
├── README.md           # Project documentation
└── .git/               # Git repository
```

## API Endpoints Used

- **FBS Games**: `https://site.api.espn.com/apis/site/v2/sports/football/college-football/scoreboard`
- **FCS Games**: `https://site.api.espn.com/apis/site/v2/sports/football/college-football/scoreboard?groups=81`
- **Team Data**: `https://site.api.espn.com/apis/site/v2/sports/football/college-football/teams`

## Features in Detail

### Team Coverage
- **FBS Conferences**: ACC, AAC, Big 12, Big Ten, C-USA, MAC, Mountain West, Pac-12, SEC, Sun Belt, Independent
- **FCS Conferences**: Big Sky, Big South-OVC, CAA, Ivy League, MEAC, Missouri Valley, Northeast, Patriot, Pioneer, Southern, Southland, SWAC, UAC
- **Non-FCS Opponents**: Division II/III teams that FCS teams play against

### Data Accuracy
- **Exact Team Counts**: Matches official 2025 season rosters
- **Conference Alignment**: Accurate conference assignments
- **Logo Integration**: High-quality team logos with fallback text
- **Score Display**: Real-time scores and game outcomes

## Development

This is a single-file application that can be run locally or hosted on any web server. No build process or dependencies required.

## License

This project is open source and available under the MIT License.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

---

**Note**: This application is for educational and informational purposes. All team data and logos are property of their respective organizations and ESPN.
