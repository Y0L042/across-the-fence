class cfgfunctions
{
	//Function definitions for mission-specific paradigm features.
	/*
	class para_interop {
		class interop {
			file = "functions\paradigm_interop";
			class get_squad_composition {};
			class valid_attack_angles {};
		};
	};
	*/
	class vn_an
	{

		class client
		{
			class update_loading_screen {};
		};

		class init
		{
			class post_init
			{
				postinit = 1;
			};
		};

		class server
		{
		};

	};
};
