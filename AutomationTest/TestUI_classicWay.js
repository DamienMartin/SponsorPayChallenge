<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="Content-Style-Type" content="text/css">
  <title></title>
  <meta name="Generator" content="Cocoa HTML Writer">
  <meta name="CocoaVersion" content="1334">
  <style type="text/css">
    p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 11.0px Menlo; min-height: 13.0px}
    p.p2 {margin: 0.0px 0.0px 0.0px 0.0px; font: 11.0px Menlo}
    span.s1 {font-variant-ligatures: no-common-ligatures}
  </style>
</head>
<body>
<p class="p1"><span class="s1"></span><br></p>
<p class="p2"><span class="s1">target = UIATarget.localTarget();</span></p>
<p class="p2"><span class="s1">application = target.frontMostApp();</span></p>
<p class="p2"><span class="s1">mainWindow = application.mainWindow();</span></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p2"><span class="s1">// Get all necessary UI element</span></p>
<p class="p2"><span class="s1">var form = UIATarget.localTarget().frontMostApp().mainWindow().scrollViews()[0]</span></p>
<p class="p2"><span class="s1">var uidTextField = form.textFields()["uidTextField"];</span></p>
<p class="p2"><span class="s1">var appIdTextField = form.textFields()["appIdTextField"];</span></p>
<p class="p2"><span class="s1">var apiKeyTextField = form.textFields()["apiKeyTextField"];</span></p>
<p class="p2"><span class="s1">var pub0TextField = form.textFields()["pub0TextField"];</span></p>
<p class="p2"><span class="s1">var validateButton = form.buttons()["validateButton"];</span></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p2"><span class="s1">// Verify if textFields are well filled.</span></p>
<p class="p2"><span class="s1">assertEquals( uidTextField.value(),<span class="Apple-converted-space">  </span>"spiderman", "UID wrong : " + uidTextField.value() + "!= spiderman");</span></p>
<p class="p2"><span class="s1">assertEquals( appIdTextField.value(),<span class="Apple-converted-space">  </span>"2070", "AppId wrong : " + uidTextField.value() + "!= spiderman");</span></p>
<p class="p2"><span class="s1">assertFalse( apiKeyTextField.value() == "",<span class="Apple-converted-space">  </span>"APIKey not pre-filled");</span></p>
<p class="p2"><span class="s1">assertEquals( pub0TextField.value(),<span class="Apple-converted-space">  </span>"pub0 value", "Pub0 wrong : " + uidTextField.value() + "!= pub0 value");</span></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p2"><span class="s1">// Tap on validate button to launch request</span></p>
<p class="p2"><span class="s1">validateButton.tap();</span></p>
<p class="p2"><span class="s1">var navBar = mainWindow.navigationBar();</span></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p2"><span class="s1">// Waiting offers request<span class="Apple-converted-space"> </span></span></p>
<p class="p2"><span class="s1">UIATarget.localTarget().delay(10);</span></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p2"><span class="s1">// Test if offers was display !</span></p>
<p class="p2"><span class="s1">assertEquals( navBar.name(),<span class="Apple-converted-space">  </span>"Offers", "Wrong NavBar : " + navBar.name() + "!= Offers");</span></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p2"><span class="s1">// Manual Assertion<span class="Apple-converted-space"> </span></span></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p2"><span class="s1">function assertEquals(expected, received, message) {</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">    </span>if (received != expected) {</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">        </span>if (! message) message = "Expected " + expected + " but received " + received;</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">        </span>throw message;</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">    </span>}</span></p>
<p class="p2"><span class="s1">}</span></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p2"><span class="s1">function assertTrue(expression, message) {</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">    </span>if (! expression) {</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">        </span>if (! message) message = "Assertion failed";</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">        </span>throw message;</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">    </span>}</span></p>
<p class="p2"><span class="s1">}</span></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p2"><span class="s1">function assertFalse(expression, message) {</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">    </span>assertTrue(! expression, message);</span></p>
<p class="p2"><span class="s1">}</span></p>
<p class="p1"><span class="s1"></span><br></p>
<p class="p2"><span class="s1">function assertNotNull(thingie, message) {</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">    </span>if (thingie == null || thingie.toString() == "[object UIAElementNil]") {</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">        </span>if (message == null) message = "Expected not null object";</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">        </span>throw message;</span></p>
<p class="p2"><span class="s1"><span class="Apple-converted-space">    </span>}</span></p>
<p class="p2"><span class="s1">}</span></p>
</body>
</html>
