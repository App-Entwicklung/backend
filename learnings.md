# Learnings

---

## Grundlagen

### Besonderheiten

- Es gibt kein `null` in Solidity
- uninitialisierte Variablen werden mit Default-Werten initialisiert
  - `uint` &rarr; `0`
  - `string` &rarr; `''`
  - `array` &rarr; `[]`
  - `bool` &rarr; `false`

### msg-Object:

- Objekt wird zu Contract geschickt

```java
  address sender = msg.sender; //Adresse (Account) des Senders
  uint transactionValue = msg.value; // Wert in wei
  bytes data = msg.data // enthält encoded argumente der transaktion
  bytes signature = msg.sig // enthält function identifier
```

### comparisons:

- Strings nicht mit "=="

```java
  bool equals = str1 == str2; // funktioniert nicht
```

- String vergleich durch hash-functions wie z. B. keccak256(str)

```java
  bool equals = keccak256(str1) == keccak256(str2); // funktioniert nicht
```

### Speichern in smart-contracts:

- storage
  - für contract state
  - bleibt zwischen verschiedenen calls bestehen
  - teuer &rarr; bis zu 20.000 gas

```ts
  function sendMessage(string storage message) {
    //code
  }
```

- memory
  - für temporäre Variablen
  - bleibt nur für methodenaufruf bestehen
  - günstig &rarr; 3gas

```ts
  function sendMessage(string memory message) {
    VoteOption memory optionPos = posOfOption[optionName];
    //code
  }
```

- calldata
  - schwächste Form
  - kann nicht verwendet werden, wenn auf Basis dieser Variable state geändert wird

```ts
  function sendMessage(string calldata message) {
    //code
  }
```

### Modifier

#### Functions

- Access Modifier:
  - kein modifier gleicht dem `public`-modifier
  - Functions mit modifier...
    - `external`können <b>nur</b> von außerhalb aufgerufen werden
    - `public` können von jedem aufgerufen werden
    - `internal` / `private` können <b>nur</b> von innerhalb / anderen Functions aufgerufen werden
- Zusätzliche Modifier:
  - Funktionen mit `view`-modifier ändern nicht den State des Contracts, greift aber auf Felder dessen zu
  - Funktionen mit `pure`-modifier können nur eigene Kalkulationen vornehmen und nicht mal auf Felder des Contracts zugreifen

#### Fields

- kein modifier gleicht dem `private`-modifier
- `public` Attribute kann jeder lesen, von außerhalb kann nicht geschrieben werden
- `internal` / `private` Attribute können nur von innerhalb des contracts gelesen und bearbeitet werden

---

## Validation Methoden

### Require

```ts
require(bool)
require(bool, 'Error String')
```

- Wenn bool falsch ist wird die Ausführung gestoppt und bisherige Änderungen werden rückgängig gemacht
- optionaler String gibt Nachricht an User
- Bei require wird ungenutzes gas wieder an User zurücküberwiesen

### Assert

```ts
assert(bool)
```

- Verwendung meist von internen Feldern / Methoden
- Genutzt um einen internen Stand des Contracts zu überprüfen
- Wenn bool false ist, fast gleiches Verhalten wie bei `require`()
- übriges gas wird dem nutzer nicht zurückgegeben <br>
  &rarr; Wenn interner Stand kaputt, gut möglich, dass ein Hacking-Angriff versucht wird <br>
  &rarr; punishment des hackers

### Revert

```ts
revert()
```

- bricht Bedingungslos ab
- Verhalten wie bei `require`()
- meist benutzt in if-Block

---

## Limitations

- Durch Contracts ist kein Zugriff auf Außenwelt möglich <br /> &rarr;
  Keine API-Calls können abgesetzt werden
- Durch Contracts können keine echt-zufälligen Zahlen generiert werden <br /> &rarr;
  Andere könnten Contract dann nicht validieren

---

## Datenstrukturen

### Arrays

- Arrays sind Refernzobjekte
- Zugriff und Änderungen wie bei Java / JS etc.
- Wenn keine direkte initialisierung immer mit `[]` initialisiert

```ts
  uint[] arr2 = arr1 // erstellt nur referenz, kein 2. Objekt
  arr2[0] = 12 //ändert auch arr1
```

- Dynamische Arrays

```ts
  uint[] dynamic; //dynamisches Array
  uint[] dynamic2 = new uint[](2); //dynamisches Array der Länge 2
  uint newSize = array.push(elem); // Hängt elem an und gibt neue Länge zurück
```

- Statische Arrays

```ts
  uint[5] arr5; // erzeugt ein statisches Array der Länge 5
  arr5.push(elem); //wird nicht funktionieren, da arr5 statisch ist
```

### Mapping

- Mappings ähneln stark key-value pairs von JS/TS
- Mappings geben, wenn kein value für key existiert Default-Wert für den Value-Type zurück

```ts
  mapping( keyType => valueType ) mapName;
  mapName[key] = value;
  var value = map[key];
```

- Limitations:

  - Keine total number of items
  - kein Check, ob ein key existiert
  - nicht einfach all keys zu bekommen

  &rarr; Workarounds sind möglich

### Struct

- Eigener Typ des Nutzers
- Sammlung von Feldern
- vgl. mit Klasse ohne Methoden oder JS Objekten
- Zugriff über struct.attribut
- falls struct nicht initialisiert wird, enthält jedes Attribut seinen Default-Wert

```java
  Struct Person{
    string name;
    string nachname;
    uint alter;
  }
```
