#! /bin/bash
#Script to generate random number between 1 and 1000 for users to guess

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#generate random number
SECRET_NUMBER=$(( RANDOM%1000 + 1 ))
echo $SECRET_NUMBER

PLAY_GAME() {
  #ask for username input
  echo "Enter your username:"
  read USERNAME

  #is user already in database
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")

  if [[ -z $USER_ID ]]
  then
    #print welcome message
    echo "Welcome, $USERNAME! It looks like this is your first time here."

    #user does not exist; enter user data into database
    INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")

    #get user id
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

  else 
    #user exists in database, get user data
    USER_DATA=$($PSQL "SELECT games_played, best_game FROM users WHERE user_id=$USER_ID")

    IFS="|"   
    read GAMES_PLAYED BEST_GAME <<< $USER_DATA
    unset IFS
    
    #print welcome back message
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."

  fi

  GET_GUESS "Guess the secret number between 1 and 1000:"
  NUM_GUESSES=1

  CHECK_GUESS

}

GET_GUESS() {
  #ask user to guess secret number
  echo "$1"
  read GUESS_NUMBER

  # if input is not an integer
  until [[ $GUESS_NUMBER =~ ^[0-9]+$ ]]
  do
    # ask to guess again
    echo "That is not an integer, guess again:"
    read GUESS_NUMBER
  done
}

CHECK_GUESS() {
  #until guess equals secret number
  while [[ $GUESS_NUMBER != $SECRET_NUMBER ]]
  do
    if [[ $GUESS_NUMBER > $SECRET_NUMBER ]]
    then
      GET_GUESS "It's lower than that, guess again:"
    else
      GET_GUESS "It's higher than that, guess again:"
    fi
    NUM_GUESSES=$(( NUM_GUESSES+1 ))
  done

  #guess equal secret number
  echo "You guessed it in $NUM_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

  #get latest game id for the user
  MAX_GAME_ID=$($PSQL "SELECT MAX(game_id) FROM games WHERE user_id=$USER_ID")

  #if no game id exists for the user
  if [[ -z $MAX_GAME_ID ]]
  then
    GAME_ID=1
  else
    GAME_ID=$(( MAX_GAME_ID+1 ))
  fi

  #add game data for the user
  INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(user_id, game_id, number_of_guesses) VALUES($USER_ID, $GAME_ID, $NUM_GUESSES)")

  #update users database
  UPDATE_USERS_RESULT=$($PSQL "UPDATE users SET games_played=(SELECT COUNT(*) FROM games WHERE user_id=$USER_ID), best_game=(SELECT MIN(number_of_guesses) FROM games WHERE user_id=$USER_ID) WHERE user_id=$USER_ID")
}
PLAY_GAME
