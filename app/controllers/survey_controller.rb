class SurveyController < ApplicationController
	include AddResponse
	include FetchQuestions
	include ThreadHelpers
	MAX_RESPONSES = 3
	
	def bg
		# Keep track of session nbs
		unless checkSessionNb(0,true) then return end
		session[:completed] = false
		
		# Generate threads + initialize session for new user
		initializeSession
		
		# Initialize member fields
		fetchQuestions(["qtype = ?", :bg])
		@title = 'Background Questions'
		@formName = :backgroundQuestions
	end
	
	def createBg
		# Keep track of session nbs
		unless checkSessionNb(0,false) then return end
		updateSessionNb(1)
		
		answers = params[:backgroundQuestions].permit!.to_h
		userID = session.id
		addResponse('Background Questions', answers, userID)
		redirect_to survey_instructions_path
	end
	
	def instructions
		unless checkSessionNb(1,true) then return end
	end
	
	def proceedToThreads
		unless checkSessionNb(1,false) then return end
		updateSessionNb(2)
		redirect_to survey_thread1_path
	end
	
	def thread1
		unless checkSessionNb(2,true) then return end
		generateThread(1)
	end
	
	def proceed1
		# Keep track of session nbs
		unless checkSessionNb(2,false)then return end
		updateSessionNb(3)
		
		redirect_to survey_thread2_path
	end
	
	def thread2
		unless checkSessionNb(3,true) then return end
		
		generateThread(2)
	end
	
	def proceed2
		# Keep track of session nbs
		unless checkSessionNb(3,false) then return end
		updateSessionNb(4)
		
		redirect_to survey_thread3_path
	end
	
	def thread3
		unless checkSessionNb(4,true) then return end
		
		generateThread(3)
	end
	
	def proceed3
		# Keep track of session nbs
		unless checkSessionNb(4,false) then return end
		updateSessionNb(5)
		
		
		redirect_to survey_thread4_path
	end
	
	def thread4
		unless checkSessionNb(5,true) then return end
		
		generateThread(4)
	end
	
	def proceed4
		# Keep track of session nbs
		unless checkSessionNb(5,false) then return end
		updateSessionNb(6)
		
		
		redirect_to survey_exit_path
	end
	
	def exit
		unless checkSessionNb(6,true) then return end
		
		# Initialize member fields
		fetchQuestions(["qtype = ?", :eg])
		@title = 'Feedback'
		@formName = :backgroundQuestions
	end
	
	def proceedToThankyou
		unless checkSessionNb(6,false) then return end
		updateSessionNb(7)
		
		redirect_to done_path
	end
	
	def thankyou
		unless checkSessionNb(7,true) then return end
		deleteSessionNb()
		
		@sessionNb = session.id
	
	end
	
	private
	def generateThread(nb)
		# Get threadID
		if session[:completedPages].key? nb.to_s # If page is visited earlier, get cached threadID
			@threadID = session[:completedPages][nb.to_s]
		elsif session[:randomPage] == nb
			@threadID = Sentence.find(-1).thread_id
			session[:completedPages][nb.to_s] = @threadID
		else 
			@threadID = session[:threads].pop
			session[:completedPages][nb.to_s] = @threadID
		end
		
		@form = 'thread' + nb.to_s
		@user_id = session[:id]
		@sentences = getThreadSentenceMapping @threadID
		session[:toAnswer] += getSentenceIDs @threadID
		session[:toAnswer] &= getSentenceIDs @threadID # Remove duplicates
		nextPath = 'survey_thread' + nb.to_s + '_path'
		@nextPath =  eval("#{nextPath}")
		render :layout => false
	end
	
	def checkSessionNb(pageNb, isGet)
		if session.key? :page and not session[:completed]
			if session[:page] == pageNb then 
				return true
			else
				path = pageNbToPath(session[:page])
				redirect_to path
				return false
			end
		else
			if isGet and pageNb == 0 
				# If new user on the first page, return true so that calling method does not exit
				return true 
			else
				redirect_to pageNbToPath(0)
				return false
			end
		end
	end
	
	def pageNbToPath(pageNb)
		if pageNb == 0
			return survey_bg_path
		elsif pageNb == 1
			return survey_instructions_path
		elsif pageNb == 2
			return survey_thread1_path
		elsif pageNb == 3
			return survey_thread2_path
		elsif pageNb == 4
			return survey_thread3_path
		elsif pageNb == 5
			return survey_thread4_path
		elsif pageNb == 6
			return survey_exit_path
		end
	end
	
	def updateSessionNb(pageNb)
		session[:page] = pageNb
	end
	
	def deleteSessionNb
		session[:completed] = true
	end
	
	def initializeSession
		session[:threads] = generateThreads(MAX_RESPONSES) # The threads that this user will be assessing
		prng = Random.new
		session[:randomPage] = Random.rand(1..4) # Randomly decide which page is going to display the dummy question
		session[:page] = 0 # To keep track of completed pages and threads
		session[:answeredSentences] = [] # IDs of all sentences whose questions have already been answered
		session[:toAnswer] = [] # IDs of sentences whose questions should be answered so far to go to next page
		session[:completedPages] = {} # Links every page number to its respectiv thread ID
	end
end