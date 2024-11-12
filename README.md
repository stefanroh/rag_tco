**Anleitung für den Kostenkalkulator**

**1. Anpassen der Datengrundlage**

Im Kostenkalkulator sind bereits verschiedene Produkte von GCP, AWS und Azure hinterlegt. Bei Bedarf können diese Produkte abgeändert oder ergänzt werden.

- **Ändern**: Zunächst auf „**Architecture Components**“ klicken und bei der gewünschten Komponente „**Edit**“ auswählen. Name, Provider, Typ und Fixkosten können hier angepasst werden. Um Kostenkomponenten zu ändern, ebenfalls „**Edit**“ bei der entsprechenden Komponente auswählen. Anschließend können Name, Preis, Referenzmenge, Abrechnungsmethode (nur volle Einheiten oder proportional), Inklusivmengen, Mindestmengen sowie eine Standardformel angepasst werden. Das Fenster wird durch Klick auf „**Save**“ geschlossen.
- **Hinzufügen**: Am Ende der Liste den Namen der neuen Architekturkomponente eingeben und „**Add**“ klicken. Die hinzugefügte Komponente kann anschließend wie oben beschrieben bearbeitet werden. Um eine neue Preiskomponente hinzuzufügen, innerhalb des Editierfensters einer Architekturkomponente den Namen am Ende der Liste eingeben und „**Add**“ klicken. Auch diese Komponente kann anschließend bearbeitet werden.

**2. Anpassen der Variablen**

Variablen dienen dazu, die Mengen leichter bestimmen zu können, mit denen Architekturkomponenten aufgerufen werden. Sie können durch einen Klick auf „**Variables**“ eingesehen werden.

- **Ändern**: Zum Anpassen einer Variable den entsprechenden Wert ändern und das Fenster durch Klick auf „**Save**“ speichern.
- **Hinzufügen**: Am Ende der Variablenliste den Namen und den Wert der neuen Variable eingeben und durch Klicken auf „**Add**“ hinzufügen.

**3. Hinzufügen von Architekturkomponenten zum Use Case**

Um die Kosten eines Use Cases zu berechnen, müssen die entsprechenden Architekturkomponenten hinzugefügt werden.

- **Filtern**: Der Provider und der Typ können über die ersten beiden Dropdown-Menüs spezifiziert werden.
- **Auswählen**: Anschließend werden im dritten Dropdown-Menü die gefilterten Architekturkomponenten angezeigt.
- **Hinzufügen**: Durch Klicken auf „**Add**“ wird die ausgewählte Komponente dem Use Case hinzugefügt.

**4. Angeben der Mengenformeln**

Für jede Preiskomponente muss eine Mengenformel angegeben werden, um die Berechnung der Architekturkomponenten zu ermöglichen. In diesen Formeln kann auf zuvor definierte Variablen zugegriffen werden.

- **Schreibweise**: Formeln können entweder in **Infix**- oder **Prefix**-Schreibweise eingegeben werden. Bei komplexeren Formeln (z.B. mit Klammern) ist nur die Prefix-Schreibweise möglich.
- **Operatoren**: Eine Übersicht der verwendbaren Operatoren ist in der Dokumentation der Bibliothek „formula\_parser“ verfügbar: <https://pub.dev/packages/formula_parser>.

**Beispiele für Formeln:**

- Fester Wert: 5
- Variable: #inputToken
- Infix: #requestsPerDay \* tokenPerRequest
- Prefix: MUL(#requestsPerDay, tokenPerRequest)

**5. Kosten berechnen**

Durch Klicken auf „**Calculate Cost**“ werden die Kosten für alle Architekturkomponenten im Use Case berechnet. Die Ergebnisse werden links in tabellarischer Form, aufgeteilt nach Kostenkomponenten, und rechts als Balkendiagramm dargestellt.