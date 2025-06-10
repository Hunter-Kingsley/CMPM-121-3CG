# 3CG (Casual Collectible Card Game)

## Programming Patterns
- Flyweight pattern used to compartmentalize card values and reduce clutter
- Event Queue used to stagger card reveals and actions so the entire turn doesn't happen in a single frame
- Subclass Sandbox used to streamline card effect implementation
- State Pattern used to track whether the card can or cannot be grabbed
- Command Pattern used to not duplicate code for the AI players (they use the same actions as the real player)
- Dirty Flag used to track whether the game has ended or not
- TODO: Observer used to display the current hovered card's title and description

## People who helped
- Jason Rangel-Martinez
- Andy Newton
- Tyler Torrella

## Postmortem
- I'm really happy with the way this project has turned out from a architecture standpoint. This project had way more planning go into it before I even started coding, so functionality is much more modular, compartmentalized, and readable than solitare. While the planning helped a ton, I still think I could have spent even more time planning out either the specifics of how different structures were tethered to one another, or just a timeline for when I was going to implemenet what to reduce fixing unnecessary bugs. I could have also put more effort into planning out a slightly less convoluted way to have the cards use both the flyweight and prototype pattern without hooking the prototype functions up to the data class rather than the card itself. It ended up not impeding me too much, but it took a fair ammount of time to conceptually wrap my head around.

## Imported Assets
- Wooden Cow PNG: https://pngtree.com/freepng/trojan-horse_15867307.html
- Pegasus PNG: https://www.pngall.com/pegasus-png/download/107866/
- Minotaur PNG: https://officialpsds.com/minotaur-greek-mythology-psd-79j2m0
- Titan PNG: https://imgbin.com/png/ApVutYdu/atlas-hades-statue-greek-mythology-titan-png
- Ares PNG: https://pngtree.com/freepng/mythological-greek-god-of-war-ares-design_15562429.html
- Cyclops PNG: https://pixels.com/featured/greek-mythology-cyclops-nikolay-todorov.html?product=beach-towel
- Artemis PNG: https://nikolay-todorov.pixels.com/featured/greek-goddess-artemis-nikolay-todorov.html?product=greeting-card
- Hades PNG: https://fineartamerica.com/featured/greek-god-hades-nikolay-todorov.html?product=tapestry
- Dionysus PNG: https://thenounproject.com/browse/icons/term/dionysus/
- Hermes PNG: https://pngtree.com/freepng/hermes-mercury-greek-god-flying_8456060.html
- Ship Of Theseus PNG: https://www.pngegg.com/en/png-cilpm
- Midas PNG: https://wallpapers.com/png/midas-immortal-king-png-voh35-48626m9fvxn3dke3.html
- Persephone PNG: https://pngtree.com/freepng/cute-demeter-goddess-of-the-agriculture_14993583.html
- Pandora PNG: https://www.flaticon.com/free-icon/pandora_4793142
- Icarus PNG: https://imgbin.com/png/eQFxT3X4/icarus-greek-mythology-game-png
- Nyx PNG: https://pngtree.com/freepng/dark-gothic-woman-with-starry-eyes-as-nyx_8688082.html
- Helios PNG: https://pngtree.com/freepng/helios-or-sol-vintage_15376905.html