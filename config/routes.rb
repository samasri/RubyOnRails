Rails.application.routes.draw do
	root to: 'pages#home'
	resources :tasks,  except:  [:index]
	
	get '/responses/new', to: 'responses#new'
	post '/responses/new', to: 'responses#create'
	
	get '/responses/newLastResponse', to: 'responses#newLastResponse'
	post '/responses/newLastResponse', to: 'responses#createLastResponse'
	
	get '/survey/bg', to: 'survey#bg'
	post '/survey/bg', to: 'survey#createBg'
	
	get '/survey/instructions', to: 'survey#instructions'
	post '/survey/proceedToThreads', to: 'survey#proceedToThreads'
	
	get '/survey/thread1', to: 'survey#thread1'
	post '/survey/thread1', to: 'survey#proceed1'
	
	get '/survey/thread2', to: 'survey#thread2'
	post '/survey/thread2', to: 'survey#proceed2'
	
	get '/survey/thread3', to: 'survey#thread3'
	post '/survey/thread3', to: 'survey#proceed3'
	
	get '/survey/thread4', to: 'survey#thread4'
	post '/survey/thread4', to: 'survey#proceed4'
	
	get '/survey/exit', to: 'survey#exit'
	post '/survey/exit', to: 'survey#proceedToThankyou'	
	
	get '/done', to: 'survey#thankyou'
	
	get 'testLoadBalancing', to: 'test#testLoadBalancing'
	get 'testSentenceHighlighting', to:'test#testSentenceHighlighting'
end
