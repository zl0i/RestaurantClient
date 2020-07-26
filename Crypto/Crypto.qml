pragma Singleton
import QtQuick 2.0

QtObject {

    function sha1 ( str ) {	// Calculate the sha1 hash of a string
        //
        // +   original by: Webtoolkit.info (http://www.webtoolkit.info/)
        // + namespaced by: Michael White (http://crestidg.com)

        var rotate_left = function(n,s) {
            var t4 = ( n<<s ) | (n>>>(32-s));
            return t4;
        };

        function utf8_encode ( str_data ) {	// Encodes an ISO-8859-1 string to UTF-8
            // +   original by: Webtoolkit.info (http://www.webtoolkit.info/)
            str_data = String(str_data)
            str_data = str_data.replace(/\r\n/g,"\n");
            var utftext = "";

            for (var n = 0; n < str_data.length; n++) {
                var c = str_data.charCodeAt(n);
                if (c < 128) {
                    utftext += String.fromCharCode(c);
                } else if((c > 127) && (c < 2048)) {
                    utftext += String.fromCharCode((c >> 6) | 192);
                    utftext += String.fromCharCode((c & 63) | 128);
                } else {
                    utftext += String.fromCharCode((c >> 12) | 224);
                    utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                    utftext += String.fromCharCode((c & 63) | 128);
                }
            }
            return utftext;
        }

        var lsb_hex = function(val) {
            var str="";
            var i;
            var vh;
            var vl;

            for( i=0; i<=6; i+=2 ) {
                vh = (val>>>(i*4+4))&0x0f;
                vl = (val>>>(i*4))&0x0f;
                str += vh.toString(16) + vl.toString(16);
            }
            return str;
        };

        var cvt_hex = function(val) {
            var str="";
            var i;
            var v;

            for( i=7; i>=0; i-- ) {
                v = (val>>>(i*4))&0x0f;
                str += v.toString(16);
            }
            return str;
        };

        var blockstart;
        var i, j;
        var W = new Array(80);
        var H0 = 0x67452301;
        var H1 = 0xEFCDAB89;
        var H2 = 0x98BADCFE;
        var H3 = 0x10325476;
        var H4 = 0xC3D2E1F0;
        var A, B, C, D, E;
        var temp;

        str = utf8_encode(str);
        var str_len = str.length;

        var word_array = [];
        for( i=0; i<str_len-3; i+=4 ) {
            j = str.charCodeAt(i)<<24 | str.charCodeAt(i+1)<<16 | str.charCodeAt(i+2)<<8 | str.charCodeAt(i+3);
            word_array.push( j );
        }

        switch( str_len % 4 ) {
        case 0:
            i = 0x080000000;
            break;
        case 1:
            i = str.charCodeAt(str_len-1)<<24 | 0x0800000;
            break;
        case 2:
            i = str.charCodeAt(str_len-2)<<24 | str.charCodeAt(str_len-1)<<16 | 0x08000;
            break;
        case 3:
            i = str.charCodeAt(str_len-3)<<24 | str.charCodeAt(str_len-2)<<16 | str.charCodeAt(str_len-1)<<8	| 0x80;
            break;
        }

        word_array.push( i );

        while((word_array.length % 16) != 14) word_array.push(0);

        word_array.push( str_len>>>29 );
        word_array.push( (str_len<<3)&0x0ffffffff );

        for ( blockstart=0; blockstart<word_array.length; blockstart+=16 ) {
            for( i=0; i<16; i++ ) W[i] = word_array[blockstart+i];
            for( i=16; i<=79; i++ ) W[i] = rotate_left(W[i-3] ^ W[i-8] ^ W[i-14] ^ W[i-16], 1);

            A = H0;
            B = H1;
            C = H2;
            D = H3;
            E = H4;

            for( i= 0; i<=19; i++ ) {
                temp = (rotate_left(A,5) + ((B&C) | (~B&D)) + E + W[i] + 0x5A827999) & 0x0ffffffff;
                E = D;
                D = C;
                C = rotate_left(B,30);
                B = A;
                A = temp;
            }

            for( i=20; i<=39; i++ ) {
                temp = (rotate_left(A,5) + (B ^ C ^ D) + E + W[i] + 0x6ED9EBA1) & 0x0ffffffff;
                E = D;
                D = C;
                C = rotate_left(B,30);
                B = A;
                A = temp;
            }

            for( i=40; i<=59; i++ ) {
                temp = (rotate_left(A,5) + ((B&C) | (B&D) | (C&D)) + E + W[i] + 0x8F1BBCDC) & 0x0ffffffff;
                E = D;
                D = C;
                C = rotate_left(B,30);
                B = A;
                A = temp;
            }

            for( i=60; i<=79; i++ ) {
                temp = (rotate_left(A,5) + (B ^ C ^ D) + E + W[i] + 0xCA62C1D6) & 0x0ffffffff;
                E = D;
                D = C;
                C = rotate_left(B,30);
                B = A;
                A = temp;
            }

            H0 = (H0 + A) & 0x0ffffffff;
            H1 = (H1 + B) & 0x0ffffffff;
            H2 = (H2 + C) & 0x0ffffffff;
            H3 = (H3 + D) & 0x0ffffffff;
            H4 = (H4 + E) & 0x0ffffffff;
        }
        temp = cvt_hex(H0) + cvt_hex(H1) + cvt_hex(H2) + cvt_hex(H3) + cvt_hex(H4);
        return temp.toLowerCase();
    }

}
