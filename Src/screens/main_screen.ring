
class MainButtonsList from qScrollArea
	oLayout oWidget
	btnMainAzkarSabah
	btnMainAzkarMasaa
	btnMainAzkarSleep
	btnMainAzkarAfterSleep
	btnMainAzkarGreat
	subStyle = 'QScrollArea{ margin-bottom:20px ;}'

	func init pWidget
		super.init(pWidget)
		oWidget = new qwidget() 
		oLayout = new qvboxlayout() 
		setStylesheet(cScrollWidgetStyle_withoutBar+subStyle)
		setMinimumheight((pWidget.height()/3)+50)
		setFixedwidth(pWidget.width()-20)
		
		verticalscrollbar().hide()

		if iswebassembly() or ismobile() # 'cpp function to handel scroll using phones'
			MakeWidgetScrollAble_Bytouch(pObject)
		ok

		btnMainAzkarSabah = new MainButton(pWidget) {
			setFont(oMainAppFont)
			setText('اذكار الصباح')
			setClickevent(method(:pGo_Sabah_adhkar))
		}
		btnMainAzkarMasaa = new MainButton(pWidget) {
			setFont(oMainAppFont)
			setText('اذكار المساء')
			setClickevent(method(:pGo_Masaa_adhkar))
		}

		btnMainAzkarSleep = new MainButton(pWidget) {
			setFont(oMainAppFont)
			setText('اذكار النوم')
			setClickevent(method(:pGo_Sleep_adhkar))
		}

		btnMainAzkarAfterSleep = new MainButton(pWidget) {
			setBigText('أذكار الإستيقاظ من النوم')
			setFont(oMainAppFont)
			setClickevent(method(:pGo_after_Sleep_adhkar))
		}
		btnMainAzkarGreat = new MainButton(pWidget) {
			setText('أذكار عظيمة')
			setFont(oMainAppFont)
			setClickevent(method(:pGo_great_adhkar))
		}

		oLayout{
			nSpaceBetween = 8
			addWidget(this.btnMainAzkarSabah)
				addSpacing(nSpaceBetween)
			addWidget(this.btnMainAzkarMasaa)
				addSpacing(nSpaceBetween)
			addWidget(this.btnMainAzkarSleep)
				addSpacing(nSpaceBetween)
			addWidget(this.btnMainAzkarAfterSleep)
				addSpacing(nSpaceBetween)
			addWidget(this.btnMainAzkarGreat)
		}
		# 'Setting Alignment for qscrollArea'
		setAlignment(qt_AlignHCenter | qt_AlignVCenter)
		ensureWidgetVisible(this.btnMainAzkarMasaa ,20,0)
		oWidget.setLayout(oLayout)
		setWidget(oWidget)
		return self

class MainScreen From QWidget
	Adhkar_label 
	oVersionAndNotesBtn
	oScrollArea
	oMainScreen_Layout

	func init pWidget
		super.init()
		ConfigureScreen(pWidget)
		setLayout(oMainScreen_Layout)

		return self

	func ConfigureScreen pWidget

		Adhkar_label = new qLabel(pWidget) {
			setFont(oMainAppFont)

			setText(cAppTitle)
			ConfLbl(this.Adhkar_label)
			setStylesheet('QLabel{font-size:50px;background:none;}')
			setAlignment(qt_alignHcenter | qt_alignVcenter)
		}
		oVersionAndNotesBtn = new qpushbutton(pWidget) {
			setText(cVersion_notes_btnText)
			setClickEvent(method(:pShowVersion_note))
			setStyleSheet(cVersion_notes_btn_style)
			if ismobile()
				hide()
			ok
		}

		oScrollArea = new MainButtonsList(pWidget){}
		
		oMainScreen_Layout = new qvboxlayout() {
			addwidget(this.Adhkar_label)
			setAlignment(this.Adhkar_label, qt_aligntop)

			addWidget(this.oVersionAndNotesBtn)
			setAlignment(this.oVersionAndNotesBtn, qt_AlignHCenter | qt_AlignVCenter)

			addWidget(this.oScrollArea)
			setAlignment(this.oScrollArea, qt_alignBottom | qt_AlignVCenter)

			//addWidget(this.btnMainAzkarSabah)
			//addWidget(this.btnMainAzkarMasaa)
			//setAlignment(this.btnMainAzkarSabah, qt_aligntop | qt_AlignVCenter)
			//setAlignment(this.btnMainAzkarMasaa, qt_aligntop | qt_AlignVCenter)
		}
