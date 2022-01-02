/**
 * [TF2] Enable Voice Spam
 */
#pragma semicolon 1
#include <sourcemod>

#pragma newdecls required

#include <sdktools>
#include <dhooks>
#include <sourcescramble>

#define PLUGIN_VERSION "1.0.0"
public Plugin myinfo = {
	name = "[TF2] Enable Voice Spam",
	author = "nosoop",
	description = "Re-enables the ability to mash pootis multiple times per second.",
	version = PLUGIN_VERSION,
	url = "https://github.com/nosoop/SM-TFVoiceSpamPatch"
}

ConVar tf_max_voice_speak_delay;

public void OnPluginStart() {
	Handle hGameConf = LoadGameConfigFile("tf2.voice_spam_fix");
	if (!hGameConf) {
		SetFailState("Failed to load gamedata (tf2.voice_spam_fix).");
	}
	
	MemoryPatch patch = MemoryPatch.CreateFromConf(hGameConf,
			"CTFPlayer::SpeakConceptIfAllowed()::BypassIsSpeaking");
	if (!patch.Enable()) {
		SetFailState("Failed to enable patch "
				... "CTFPlayer::SpeakConceptIfAllowed()::BypassIsSpeaking");
	}
	
	Handle dtShouldRunRateLimitedCommand = DHookCreateFromConf(hGameConf,
			"CBaseMultiplayerPlayer::ShouldRunRateLimitedCommand(char*)");
	if (!dtShouldRunRateLimitedCommand) {
		SetFailState("Failed to create detour %s",
				"CBaseMultiplayerPlayer::ShouldRunRateLimitedCommand(char*)");
	}
	DHookEnableDetour(dtShouldRunRateLimitedCommand, false, OnShouldRunRateLimitedCommand);
	
	delete hGameConf;
	
	tf_max_voice_speak_delay = FindConVar("tf_max_voice_speak_delay");
	if (!tf_max_voice_speak_delay) {
		SetFailState("Could not find ConVar tf_max_voice_speak_delay");
	}
	
	tf_max_voice_speak_delay.SetBounds(ConVarBound_Lower, false);
	tf_max_voice_speak_delay.SetBounds(ConVarBound_Upper, false);
	tf_max_voice_speak_delay.Flags &= ~(FCVAR_DEVELOPMENTONLY);
}

/**
 * Lifts existing restrictions on `voicemenu` so it can always be run (as long as
 * tf_max_voice_speak_delay is negative).
 */
MRESReturn OnShouldRunRateLimitedCommand(int client, Handle hReturn, Handle hParams) {
	if (tf_max_voice_speak_delay.FloatValue >= 0.0) {
		return MRES_Ignored;
	}
	
	char cmd[16];
	DHookGetParamString(hParams, 1, cmd, sizeof(cmd));
	
	if (StrEqual(cmd, "voicemenu")) {
		DHookSetReturn(hReturn, true);
		return MRES_Override;
	}
	return MRES_Ignored;
}
