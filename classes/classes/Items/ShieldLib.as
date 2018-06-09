package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	import classes.Items.Shields.*;
	import classes.PerkLib;
	import classes.PerkType;
	
	public final class ShieldLib 
	{
		public static const NOTHING:Nothing = new Nothing();
		
		public const BLASPHE:Shield = new Shield("Blasphe", "Blasphemy", "Blasphemy", "a Blasphemy", 1, 200, "Metal prayer beads, engraved with holy symbols of dead gods.", "Obsession", PerkLib.Obsession, 0.2, 0.15);
		public const BUCKLER:Shield = new Shield("Buckler", "Buckler", "buckler", "a buckler", 5, 50, "A simple wooden rounded shield.");
		public const GREATSH:Shield = new Shield("GreatSh", "GreatShld", "greatshield", "a greatshield", 12, 300, "A large metal shield.");
		public const KITE_SH:Shield = new Shield("Kite Sh", "KiteShield", "kite shield", "a kite shield", 8, 150, "An average-sized kite shield.");
		public const MABRACE:Shield = new Shield("MaBrace", "ManaBracer", "mana bracer", "a mana bracer", 2, 400, "Runed bracers such as this are popular amongst mages that can afford them. This silver bracer augments a mage’s spell power while leaving the hand open to make gestures used in spellcasting.");
		public const SPI_FOC:Shield = new Shield("Spi Foc", "SpiritFocus", "spirit focus", "a spirit focus", 4, 800, "This small icon with a silk ribbon is inscribed with eldritch runes and reinforces a kitsune's power and magic.");
		public const TRASBUC:Shield = new Shield("TraSBuc", "TrainSBuckler", "training soul buckler", "a training soul buckler", 3, 60, "A simple rounded shield made of soulmetal used to train ki by soul cultivator novices.");
		public const TOWERSH:Shield = new TowerShield();
		public const DRGNSHL:Shield = new DragonShellShield();
		public const SANCTYN:Shield = new Shield ("SanctN", "Sanctuary", "Sanctuary", "a Sanctuary", 20, 1500, "The legendary shield");
		public const SANCTYL:Shield = new Sanctuary();
		public const SANCTYD:Shield = new DarkAegis();
		
		public function ShieldLib() 
		{
		}
	}

}