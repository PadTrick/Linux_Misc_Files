import pygame
import sys

# PyGame initialisieren
pygame.init()

# Bildschirmgröße ermitteln
info = pygame.display.Info()
WIDTH, HEIGHT = info.current_w, info.current_h

# Farben definieren
COLORS = {
    'white': (255, 255, 255),
    'black': (0, 0, 0),
    'gray': (128, 128, 128),
    'red': (255, 0, 0),
    'green': (0, 255, 0),
    'blue': (0, 0, 255),
    'yellow': (255, 255, 0),
    'cyan': (0, 255, 255),
    'magenta': (255, 0, 255)
}

# Farbnamen für die Anzeige
COLOR_NAMES = list(COLORS.keys())

class ColorSlider:
    def __init__(self):
        self.visible = False
        self.width = 300
        self.height = 150
        self.x = (WIDTH - self.width) // 2
        self.y = HEIGHT - self.height - 20
        self.current_color_index = 0
        self.slider_pos = 0
        self.slider_width = 200
        self.slider_height = 20
        self.slider_x = self.x + 50
        self.slider_y = self.y + 60

    def draw(self, screen):
        if not self.visible:
            return

        # Hintergrund des Sliders
        pygame.draw.rect(screen, (50, 50, 50), (self.x, self.y, self.width, self.height))
        pygame.draw.rect(screen, (100, 100, 100), (self.x, self.y, self.width, self.height), 2)

        # Titel
        font = pygame.font.SysFont(None, 30)
        title = font.render("Farbauswahl", True, (255, 255, 255))
        screen.blit(title, (self.x + (self.width - title.get_width()) // 2, self.y + 10))

        # Aktuelle Farbe anzeigen
        current_color = COLORS[COLOR_NAMES[self.current_color_index]]
        color_text = font.render(f"Aktuelle Farbe: {COLOR_NAMES[self.current_color_index]}", True, (255, 255, 255))
        screen.blit(color_text, (self.x + 10, self.y + 40))

        # Farbvorschau
        pygame.draw.rect(screen, current_color, (self.x + self.width - 60, self.y + 35, 40, 40))

        # Slider
        pygame.draw.rect(screen, (200, 200, 200), (self.slider_x, self.slider_y, self.slider_width, self.slider_height))
        pygame.draw.rect(screen, (0, 0, 0), (self.slider_x, self.slider_y, self.slider_width, self.slider_height), 2)

        # Slider-Knopf
        knob_x = self.slider_x + self.slider_pos
        pygame.draw.rect(screen, (100, 100, 100), (knob_x - 5, self.slider_y - 5, 10, self.slider_height + 10))

        # Hilfstext
        help_font = pygame.font.SysFont(None, 20)
        help_text = help_font.render("ESC: Beenden | TAB: Slider anzeigen/verstecken", True, (200, 200, 200))
        screen.blit(help_text, (self.x + 10, self.y + self.height - 25))

    def update_slider(self, mouse_pos):
        if not self.visible:
            return

        mouse_x, mouse_y = mouse_pos
        if (self.slider_x <= mouse_x <= self.slider_x + self.slider_width and
            self.slider_y <= mouse_y <= self.slider_y + self.slider_height):
            self.slider_pos = mouse_x - self.slider_x
            self.slider_pos = max(0, min(self.slider_pos, self.slider_width))
            self.current_color_index = int((self.slider_pos / self.slider_width) * (len(COLOR_NAMES) - 1))

    def handle_event(self, event):
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_TAB:
                self.visible = not self.visible
                return True
            elif event.key == pygame.K_RIGHT:
                self.current_color_index = (self.current_color_index + 1) % len(COLOR_NAMES)
                self.slider_pos = (self.current_color_index / (len(COLOR_NAMES) - 1)) * self.slider_width
                return True
            elif event.key == pygame.K_LEFT:
                self.current_color_index = (self.current_color_index - 1) % len(COLOR_NAMES)
                self.slider_pos = (self.current_color_index / (len(COLOR_NAMES) - 1)) * self.slider_width
                return True
        elif event.type == pygame.MOUSEBUTTONDOWN and self.visible:
            self.update_slider(event.pos)
        elif event.type == pygame.MOUSEMOTION and self.visible and pygame.mouse.get_pressed()[0]:
            self.update_slider(event.pos)

        return False

    def get_current_color(self):
        return COLORS[COLOR_NAMES[self.current_color_index]]

def main():
    # Vollbild-Fenster erstellen
    screen = pygame.display.set_mode((WIDTH, HEIGHT), pygame.FULLSCREEN)
    pygame.display.set_caption("Monitor Reinigung - TAB für Farbauswahl, ESC zum Beenden")

    slider = ColorSlider()
    clock = pygame.time.Clock()

    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    running = False

            slider.handle_event(event)

        # Bildschirm mit aktueller Farbe füllen
        screen.fill(slider.get_current_color())

        # Slider zeichnen
        slider.draw(screen)

        pygame.display.flip()
        clock.tick(60)

    pygame.quit()
    sys.exit()

if __name__ == "__main__":
    main()
