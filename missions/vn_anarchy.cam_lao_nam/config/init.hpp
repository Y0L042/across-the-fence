//Use paradigm's init script to handle server and client initialisation.
use_paradigm_init = 1;

// Defines
#include "defines.hpp"
// Functions
#include "functions.hpp"

// Gamemode
#include "gamemode.hpp"
// UI
#include "interface.hpp"
// item interactions
#include "interactions.hpp"
// logistics configs
#include "logistics.hpp"
// notifications configs
#include "notifications.hpp"
// arsenal additions
#include "arsenal.hpp"
//TFAR configs
#include "tfar.hpp"
// sound configs
#include "sounds.hpp"
// Artillery module config
#include "artillery.hpp"
// Wheel menu actions
#include "wheel_menu_actions.hpp"

// load profile namespace variables for runtime use
__EXEC(allProfileNamespaceVars = allVariables profileNamespace);
