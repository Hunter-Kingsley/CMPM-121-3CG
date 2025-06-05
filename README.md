# 3CG (Casual Collectible Card Game)

## Programming Patterns
- Flyweight pattern used to compartmentalize card values and reduce clutter
- Event Queue used to stagger card reveals and actions so the entire turn doesn't happen in a single frame
- Subclass Sandbox used to streamline card effect implementation
- State used to track whether the card can or cannot be grabbed
- TODO: Observer used to display the current hovered card's title and description

## People who helped
- Jason Rangel-Martinez
- Andy Newton
- Tyler Torrella

## Postmortem
- I'm really happy with the way this project has turned out from a architecture standpoint. This project had way more planning go into it before I even started coding, so functionality is much more modular, compartmentalized, and readable than solitare. While the planning helped a ton, I still think I could have spent even more time planning out either the specifics of how different structures were tethered to one another, or just a timeline for when I was going to implemenet what to reduce fixing unnecessary bugs. I could have also put more effort into planning out a slightly less convoluted way to have the cards use both the flyweight and prototype pattern without hooking the prototype functions up to the data class rather than the card itself. It ended up not impeding me too much, but it took a fair ammount of time to conceptually wrap my head around.

## Imported Assets
- none (yet)