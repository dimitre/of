#pragma once

#include "ofxiOS.h"
#include "eventsObject.h"

class ofApp : public ofxiOSApp{
	
	public:
		void setup();
		void update();
		void draw();
	
		void exit();
	
		void touchDown(ofTouchEventArgs & touch);
		void touchMoved(ofTouchEventArgs & touch);
		void touchUp(ofTouchEventArgs & touch);
		void touchDoubleTap(ofTouchEventArgs & touch);
		void touchCancelled(ofTouchEventArgs & touch);
	
		void lostFocus();
		void gotFocus();
		void gotMemoryWarning();
		void deviceOrientationChanged(int newOrientation);
	
		//method that will receive events from ofxEventsAddon
		void newFloat(float & f);
		void newInt(int & i);
	
		eventsObject evObject;

		string floatMsg;
		string intMsg;
	
		bool enabled;
};

