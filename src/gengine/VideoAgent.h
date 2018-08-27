#ifndef HEADER_VIDEOAGENT_H
#define HEADER_VIDEOAGENT_H

class Path;

#include "BaseAgent.h"
#include "MultiDrawer.h"
#include "Name.h"
#include "V2.h"

#include "SDL2/SDL.h"

#include <vector>

/**
 * Video agent initializes video mode and
 * every cycle lets registered drawers to drawOn(screen).
 */
class VideoAgent : public BaseAgent, public MultiDrawer {
    AGENT(VideoAgent, Name::VIDEO_NAME);
    private:
        SDL_Window * m_window;
        SDL_Renderer * m_renderer;
        SDL_Texture *m_texture;
        SDL_Surface *m_screen;
        bool m_fullscreen;

        int m_ww, m_wh;
        int m_lw, m_lh;
        float m_sx, m_sy;
        int m_offsetX, m_offsetY;

    private:
        void setIcon(const Path &file);
        void changeVideoMode(int screen_width, int screen_height);
        int getVideoFlags();
        void toggleFullScreen();
    protected:
        virtual void own_init();
        virtual void own_update();
        virtual void own_shutdown();
    public:
        virtual void receiveSimple(const SimpleMsg *msg);
        virtual void receiveString(const StringMsg *msg);
        SDL_Window * window() { return m_window; }
        SDL_Surface * surface() { return m_screen; }
        V2 scaleMouseLoc(const V2 & v);
        void initVideoMode();
};

#endif
