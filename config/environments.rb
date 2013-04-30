configure :production, :development do 
	ActiveRecord::Base.establish_connection(
			:adapter => 'postgresql',
			:username => 'postgres',
			:database => 'dnb_prod',
			:encoding => 'unicode'
	)
end

