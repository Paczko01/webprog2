document.addEventListener('DOMContentLoaded', () => {
  const userGrid = document.querySelector('.grid-user');
  const computerGrid = document.querySelector('.grid-computer');
  const displayGrid = document.querySelector('.grid-display');
  const ships = document.querySelectorAll('.ship');
  const destroyer = document.querySelector('.destroyer-container');
  const submarine = document.querySelector('.submarine-container');
  const cruiser = document.querySelector('.cruiser-container');
  const battleship = document.querySelector('.battleship-container');
  const carrier = document.querySelector('.carrier-container');
  const startButton = document.querySelector('#start');
  const rotateButton = document.querySelector('#rotate');
  const turnDisplay = document.querySelector('#whose-go');
  const infoDisplay = document.querySelector('#info');
  const ship1Display = document.querySelector('#ship1');
  const ship2Display = document.querySelector('#ship2');
  const ship3Display = document.querySelector('#ship3');
  const ship4Display = document.querySelector('#ship4');
  const ship5Display = document.querySelector('#ship5');
  const userSquares = [];
  const computerSquares = [];
  let isHorizontal = true;
  let isGameOver = false;
  let currentPlayer = 'user';
  const width = 10;
  let userShips = 0;

  //Create Board
  function createBoard(grid, squares) {
    for (let i = 0; i < width*width; i++) {
      const square = document.createElement('div');
      square.dataset.id = i;
      grid.appendChild(square);
      squares.push(square);
    }
  }
  createBoard(userGrid, userSquares);
  createBoard(computerGrid, computerSquares);

  //Ships
  const shipArray = [
    {
      name: 'destroyer',
      directions: [
        [0, 1],
        [0, width]
      ]
    },
    {
      name: 'submarine',
      directions: [
        [0, 1, 2],
        [0, width, width*2]
      ]
    },
    {
      name: 'cruiser',
      directions: [
        [0, 1, 2],
        [0, width, width*2]
      ]
    },
    {
      name: 'battleship',
      directions: [
        [0, 1, 2, 3],
        [0, width, width*2, width*3]
      ]
    },
    {
      name: 'carrier',
      directions: [
        [0, 1, 2, 3, 4],
        [0, width, width*2, width*3, width*4]
      ]
    },
  ];
  const shipArray2 = [
    {
      name: 'cpudestroyer',
      directions: [
        [0, 1],
        [0, width]
      ]
    },
    {
      name: 'cpusubmarine',
      directions: [
        [0, 1, 2],
        [0, width, width*2]
      ]
    },
    {
      name: 'cpucruiser',
      directions: [
        [0, 1, 2],
        [0, width, width*2]
      ]
    },
    {
      name: 'cpubattleship',
      directions: [
        [0, 1, 2, 3],
        [0, width, width*2, width*3]
      ]
    },
    {
      name: 'cpucarrier',
      directions: [
        [0, 1, 2, 3, 4],
        [0, width, width*2, width*3, width*4]
      ]
    },
  ];

  //Draw the computers ships in random locations
  function generate(ship) {
    let randomDirection = Math.floor(Math.random() * ship.directions.length);
    let current = ship.directions[randomDirection];
    if (randomDirection === 0) direction = 1
    if (randomDirection === 1) direction = 10
    let randomStart = Math.abs(Math.floor(Math.random() * computerSquares.length - (ship.directions[0].length * direction)));

    const isTaken = current.some(index => computerSquares[randomStart + index].classList.contains('taken'));
    const isAtRightEdge = current.some(index => (randomStart + index) % width === width - 1);
    const isAtLeftEdge = current.some(index => (randomStart + index) % width === 0);

    if (!isTaken && !isAtRightEdge && !isAtLeftEdge) current.forEach(index => computerSquares[randomStart + index].classList.add('taken', ship.name))

    else generate(ship)
  }
  generate(shipArray2[0]);
  generate(shipArray2[1]);
  generate(shipArray2[2]);
  generate(shipArray2[3]);
  generate(shipArray2[4]);

  //Rotate the ships
  function rotate() {
    if (isHorizontal) {
      destroyer.classList.toggle('destroyer-container-vertical');
      submarine.classList.toggle('submarine-container-vertical');
      cruiser.classList.toggle('cruiser-container-vertical');
      battleship.classList.toggle('battleship-container-vertical');
      carrier.classList.toggle('carrier-container-vertical');
      isHorizontal = false;
      return
    }
    if (!isHorizontal) {
      destroyer.classList.toggle('destroyer-container-vertical');
      submarine.classList.toggle('submarine-container-vertical');
      cruiser.classList.toggle('cruiser-container-vertical');
      battleship.classList.toggle('battleship-container-vertical');
      carrier.classList.toggle('carrier-container-vertical');
      isHorizontal = true;
      return
    }
  }
  rotateButton.addEventListener('click', rotate);

  //move around user ship
  ships.forEach(ship => ship.addEventListener('dragstart', dragStart));
  userSquares.forEach(square => square.addEventListener('dragstart', dragStart));
  userSquares.forEach(square => square.addEventListener('dragover', dragOver));
  userSquares.forEach(square => square.addEventListener('dragenter', dragEnter));
  userSquares.forEach(square => square.addEventListener('dragleave', dragLeave));
  userSquares.forEach(square => square.addEventListener('drop', dragDrop));
  userSquares.forEach(square => square.addEventListener('dragend', dragEnd));

  let selectedShipNameWithIndex;
  let draggedShip;
  let draggedShipLength;

  ships.forEach(ship => ship.addEventListener('mousedown', (e) => {
    selectedShipNameWithIndex = e.target.id;
  }));

  function dragStart() {
    draggedShip = this;
    draggedShipLength = this.childNodes.length;
  }

  function dragOver(e) {
    e.preventDefault();
  }

  function dragEnter(e) {
    e.preventDefault();
  }

  function dragLeave() {
  }

  function dragDrop() {
    let shipNameWithLastId = draggedShip.lastChild.id;
    let shipClass = shipNameWithLastId.slice(0, -2);
    let lastShipIndex = parseInt(shipNameWithLastId.substr(-1));
    let shipLastId = lastShipIndex + parseInt(this.dataset.id);
    const notAllowedHorizontal = [0,10,20,30,40,50,60,70,80,90,1,11,21,31,41,51,61,71,81,91,2,22,32,42,52,62,72,82,92,3,13,23,33,43,53,63,73,83,93];
    const notAllowedVertical = [99,98,97,96,95,94,93,92,91,90,89,88,87,86,85,84,83,82,81,80,79,78,77,76,75,74,73,72,71,70,69,68,67,66,65,64,63,62,61,60];
    
    let newNotAllowedHorizontal = notAllowedHorizontal.splice(0, 10 * lastShipIndex);
    let newNotAllowedVertical = notAllowedVertical.splice(0, 10 * lastShipIndex);

    selectedShipIndex = parseInt(selectedShipNameWithIndex.substr(-1));

    shipLastId = shipLastId - selectedShipIndex;

    if (isHorizontal && !newNotAllowedHorizontal.includes(shipLastId)) {
      for (let i=0; i < draggedShipLength; i++) {
        userSquares[parseInt(this.dataset.id) - selectedShipIndex + i].classList.add('taken', shipClass);
      }
    //As long as the index of the ship you are dragging is not in the newNotAllowedVertical array! This means that sometimes if you drag the ship by its
    //index-1 , index-2 and so on, the ship will rebound back to the displayGrid.
    } else if (!isHorizontal && !newNotAllowedVertical.includes(shipLastId)) {
      for (let i=0; i < draggedShipLength; i++) {
        userSquares[parseInt(this.dataset.id) - selectedShipIndex + width*i].classList.add('taken', shipClass);
      }
    } else return
    userShips++;
    displayGrid.removeChild(draggedShip);
  }

  function dragEnd() {
  }

  //Game Logic
  function playGame() {
    if (userShips===5){
      infoDisplay.innerHTML = '';
      document.getElementById("start").disabled = true;
      userGo();

    }
    else {
      infoDisplay.innerHTML = 'Nem helyezted el az 5 hajódat!';
    }    
  }

  function userGo() {
    if (!isGameOver) {
      if (currentPlayer === 'user') {
        turnDisplay.innerHTML = 'Te jössz!';
        computerSquares.forEach(square => square.addEventListener('click', function(e) {
        revealSquare(square);
        }))
      }
      if (currentPlayer === 'computer') {
        turnDisplay.innerHTML = 'Ellenfél támad!';
        setTimeout(computerGo, 1000);
      }
    }
  }
  //    GAME START
  startButton.addEventListener('click', playGame);
  let destroyerCount = 0;
  let submarineCount = 0;
  let cruiserCount = 0;
  let battleshipCount = 0;
  let carrierCount = 0;


  function revealSquare(square) {
    if(!isGameOver){
      if (!square.classList.contains('boom')) {
        if (square.classList.contains('cpudestroyer')) destroyerCount++
        if (square.classList.contains('cpusubmarine')) submarineCount++
        if (square.classList.contains('cpucruiser')) cruiserCount++
        if (square.classList.contains('cpubattleship')) battleshipCount++
        if (square.classList.contains('cpucarrier')) carrierCount++
      }
      if (square.classList.contains('taken')) square.classList.add('boom')
      else square.classList.add('miss')
      checkForWins();
      currentPlayer = 'computer';
      userGo();
    }
  }

  let cpuDestroyerCount = 0;
  let cpuSubmarineCount = 0;
  let cpuCruiserCount = 0;
  let cpuBattleshipCount = 0;
  let cpuCarrierCount = 0;


  function computerGo() {
    let random = Math.floor(Math.random() * userSquares.length);
    let i =0;
    console.log(random);
    if (!userSquares[random].classList.contains('boom')&&!userSquares[random].classList.contains('miss')) {
      
      if (userSquares[random].classList.contains('destroyer')) {
        cpuDestroyerCount++;
        i=1;
        userSquares[random].classList.add('boom'); 
        }
      if (userSquares[random].classList.contains('submarine')) {
        cpuSubmarineCount++;
        i=1;
        userSquares[random].classList.add('boom'); 
        }
      if (userSquares[random].classList.contains('cruiser')) {
        cpuCruiserCount++;
        i=1;
        userSquares[random].classList.add('boom');
        }
      if (userSquares[random].classList.contains('battleship')) {
        cpuBattleshipCount++;
        i=1;
        userSquares[random].classList.add('boom'); 
        }
      if (userSquares[random].classList.contains('carrier')) {
        cpuCarrierCount++;
        i=1;
        userSquares[random].classList.add('boom');
        }
      if (i===0)userSquares[random].classList.add('miss');
      checkForWins();
    }
    else computerGo()
    currentPlayer = 'user';
    turnDisplay.innerHTML = 'Te jössz';
  }

  function checkForWins() {
    if (destroyerCount === 2) {
      infoDisplay.innerHTML = 'Elpusztítottad az ellenfeled Rombolóját!';
      ship1Display.innerHTML = 'Romboló(hossz: 2): 0 db';
      destroyerCount = 10;
    }
    if (submarineCount === 3) {
      infoDisplay.innerHTML = 'Elpusztítottad az ellenfeled Tengeralattjáróját!';
      ship2Display.innerHTML = 'Tengeralattjáró(hossz: 3): 0 db';
      submarineCount = 10;
    }
    if (cruiserCount === 3) {
      infoDisplay.innerHTML = 'Elpusztítottad az ellenfeled Cirkálóját!';
      ship3Display.innerHTML = 'Cirkáló(hossz: 3): 0 db';
      cruiserCount = 10;
    }
    if (battleshipCount === 4) {
      infoDisplay.innerHTML = 'Elpusztítottad az ellenfeled Csatahajóját!';
      ship4Display.innerHTML = 'Csatahajó(hossz: 4): 0 db';
      battleshipCount = 10;
    }
    if (carrierCount === 5) {
      infoDisplay.innerHTML = 'Elpusztítottad az ellenfeled Anyahajóját!';
      ship5Display.innerHTML = 'Anyahajó(hossz: 5): 0 db';
      carrierCount = 10;
    }
    if (cpuDestroyerCount === 2) {
      infoDisplay.innerHTML = 'Az ellendeled elpusztította a Rombolódat!';
      cpuDestroyerCount = 10;
    }
    if (cpuSubmarineCount === 3) {
      infoDisplay.innerHTML = 'Az ellendeled elpusztította a Tengeralattjáródat!';
      cpuSubmarineCount = 10;
    }
    if (cpuCruiserCount === 3) {
      infoDisplay.innerHTML = 'Az ellendeled elpusztította a Cirkálódat!';
      cpuCruiserCount = 10;
    }
    if (cpuBattleshipCount === 4) {
      infoDisplay.innerHTML = 'Az ellendeled elpusztította a Csatahajódat!';
      cpuBattleshipCount = 10;
    }
    if (cpuCarrierCount === 5) {
      infoDisplay.innerHTML = 'Az ellendeled elpusztította az Anyahajódat!';
      cpuCarrierCount = 10;
    }
    if ((destroyerCount + submarineCount + cruiserCount + battleshipCount + carrierCount) === 50) {
      infoDisplay.innerHTML = "NYERTÉL";
      gameOver();
    }
    if ((cpuDestroyerCount + cpuSubmarineCount + cpuCruiserCount + cpuBattleshipCount + cpuCarrierCount) === 50) {
      infoDisplay.innerHTML = "VESZTETTÉL";
      gameOver();
    }
  }

  function gameOver() {
    isGameOver = true;
    startButton.removeEventListener('click', userGo);
  }
})