/**
 * Coded by aimozg on 13.01.2020.
 */
package coc.data {
public class ModEncounter {
	public var id: String;
	public var poolRef: String;
	public var sceneRef: String;
	public function ModEncounter(
			id: String,
			poolRef: String,
			sceneRef: String
	) {
		this.id = id;
		this.poolRef = poolRef;
		this.sceneRef = sceneRef;
	}
}
}
