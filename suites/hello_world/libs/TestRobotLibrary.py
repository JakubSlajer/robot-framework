# Test library for Hello World suite

import random

class TestRobotLibrary:

    quotes = [
        "'The unexamined life is not worth living' - Socrates",
        "'I think therefore I am' - Rene Descartes",
        "'God is dead! He remains dead! And we have killed him.' - Friedrich Nietzsche",
        "'There is but one truly serious philosophical problem, and that is suicide' - Albert Camus",
        "'There is only one good, knowledge, and one evil, ignorance' - Socrates",
        "'You can discover more about a person in an hour of play than in a year of conversation' - Plato",
        "'Freedom is secured not by the fulfilling of one's desires, but by the removal of desire' - Epictetus",
        "'We are too weak to discover the truth by reason alone' - St. Augustine"
    ]

    @staticmethod
    def randomQuote():
        return TestRobotLibrary.quotes[random.randint(0, len(TestRobotLibrary.quotes)-1)]
