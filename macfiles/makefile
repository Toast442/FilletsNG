VERSION=1.0.1-7
PREFIX=$(HOME)/projects/root
WIDGET_OBJS=./widget/HBox.o ./widget/IWidget.o ./widget/Labels.o ./widget/WiBox.o ./widget/WiPicture.o ./widget/VBox.o \
	./widget/WiButton.o ./widget/WiStatusBar.o ./widget/WiLabel.o ./widget/Slider.o ./widget/WiContainer.o \
	./widget/WiPara.o ./plan/ScriptCmd.o ./plan/dialog-script.o
PLAN_OBJS=./plan/CommandQueue.o ./plan/SubTitleAgent.o ./plan/StateInput.o ./plan/Planner.o ./plan/ConsoleInput.o \
	./plan/StateManager.o ./plan/KeyConsole.o ./plan/FishDialog.o ./plan/GameState.o ./plan/KeyDesc.o ./plan/Keymap.o \
	./plan/Title.o ./effect/EffectNone.o ./effect/TTFException.o
EFFECT_OBJS=./effect/Picture.o ./effect/Font.o ./effect/Outline.o ./effect/SurfaceLock.o ./effect/EffectDisintegrate.o \
	./effect/LayeredPicture.o ./effect/SurfaceTool.o ./effect/EffectZx.o ./effect/WavyPicture.o ./effect/EffectMirror.o \
	./effect/EffectReverse.o ./effect/PixelIterator.o ./effect/PixelTool.o ./option/HelpInput.o ./option/MenuHelp.o
OPTION_OBJS=./option/OptionsInput.o ./option/SelectLang.o ./option/MenuOptions.o ./option/RadioBox.o
GAME_OBJS=./game/GameAgent.o ./game/Application.o ./game/main.o
STATE_OBJS=./state/demo-script.o ./state/PosterScroller.o ./state/DemoMode.o ./state/DemoInput.o ./state/PosterState.o \
	./state/GameInput.o ./state/MovieState.o
GENGINE_OBJS=./gengine/Name.o ./gengine/MixException.o ./gengine/ResImagePack.o ./gengine/Log.o ./gengine/InputHandler.o \
	./gengine/StringTool.o ./gengine/PlannedDialog.o ./gengine/FsPath.o ./gengine/VideoAgent.o ./gengine/KeyBinder.o \
	./gengine/SDLMusicLooper.o ./gengine/ResDialogPack.o ./gengine/OptionParams.o ./gengine/Random.o ./gengine/ImgException.o \
	./gengine/Dialog.o ./gengine/AgentPack.o ./gengine/DialogStack.o ./gengine/MouseStroke.o ./gengine/BaseAgent.o \
	./gengine/ScriptAgent.o ./gengine/Environ.o ./gengine/BaseException.o ./gengine/SysVideo.o ./gengine/SDLException.o \
	./gengine/ExInfo.o ./gengine/BaseMsg.o ./gengine/MultiDrawer.o ./gengine/def-script.o ./gengine/Scripter.o \
	./gengine/InputAgent.o ./gengine/OptionAgent.o ./gengine/Path.o ./gengine/StringMsg.o \
	./gengine/ResSoundPack.o ./gengine/BaseListener.o ./gengine/TimerAgent.o ./gengine/KeyStroke.o ./gengine/MessagerAgent.o \
	./gengine/ScriptState.o ./gengine/IntMsg.o ./gengine/SDLSoundAgent.o ./gengine/options-script.o ./gengine/SoundAgent.o
MENU_OBJS=./menu/LevelDesc.o ./menu/PedoInput.o ./menu/WorldInput.o ./menu/WorldMap.o ./menu/WorldBranch.o \
	./menu/NodeDrawer.o ./menu/LevelNode.o ./menu/SolverDrawer.o ./menu/Pedometer.o ./menu/worldmap-script.o
LEVEL_OBJS=./level/Landslip.o ./level/LevelInput.o ./level/Controls.o ./level/MouseControl.o ./level/ModelList.o \
	./level/LevelCountDown.o ./level/Level.o ./level/Anim.o ./level/FinderField.o ./level/StatusDisplay.o \
	./level/StepDecor.o ./level/ModelFactory.o ./level/KeyControl.o ./level/MarkMask.o ./level/View.o ./level/Room.o \
	./level/game-script.o ./level/Dir.o ./level/LevelLoading.o ./level/Shape.o ./level/LevelScript.o ./level/LevelStatus.o \
	./level/PhaseLocker.o ./level/FinderAlg.o ./level/Unit.o ./level/Field.o ./level/ShapeBuilder.o ./level/Rules.o \
	./level/Goal.o ./level/Cube.o ./level/RoomAccess.o ./level/level-script.o ./level/RopeDecor.o
GFX_OBJS=./SDL_gfx/SDL_gfxPrimitives.o

ALLOBJS=$(WIDGET_OBJS) $(PLAN_OBJS) $(EFFECT_OBJS) $(OPTION_OBJS) $(GAME_OBJS) $(STATE_OBJS) $(GENGINE_OBJS) $(MENU_OBJS) $(LEVEL_OBJS) $(GFX_OBJS)

CC=$(CCACHE) clang
CPP=$(CCACHE) clang++
DEFINES=-DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" \
	-DPACKAGE_URL=\"\" -DPACKAGE=\"fillets-ng\" -DVERSION=\"$(VERSION)\" -D_GNU_SOURCE=1 -D_THREAD_SAFE \
	-DSYSTEM_DATA_DIR=\""./Fillets.app/Contents/Resources/fillets/share/games/fillets-ng"\" -DMACOS
MISC_FLAGS=-g -arch x86_64 -arch arm64 -O2 -Wall -W -Wpointer-arith -Wcast-qual -Wcast-align -Woverloaded-virtual -Wconversion -Wshadow -mmacosx-version-min=10.11
INC_FLAGS=-Isrc/effect -Isrc/gengine -Isrc/plan -Isrc/widget -Isrc/menu -Isrc/level -Isrc/option -Isrc/state -Isrc/SDL_gfx -I$(PREFIX)/include

FRAMEWORKDIR=-F$(PREFIX)/Library/Frameworks/SDL_2.0
FRAMEWORKS=$(FRAMEWORKDIR) -arch x86_64 -arch arm64 -framework SDL2 -framework SDL2_image -framework SDL2_mixer -framework SDL2_ttf

LFLAGS=-L$(PREFIX)/lib -llua -llualib -lc++ -framework Cocoa $(FRAMEWORKS) -mmacosx-version-min=10.11 -Wl,-headerpad_max_install_names

CFLAGS=$(DEFINES) $(MISC_FLAGS) $(INC_FLAGS) $(FRAMEWORKDIR)

OBJS = $(subst ./,src/,$(ALLOBJS))

all: src/fillets

src/fillets: $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) -o src/fillets

.cpp.o:
	$(CPP) $(CFLAGS) -c $< -o $@

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS)
	rm -f src/fillets

